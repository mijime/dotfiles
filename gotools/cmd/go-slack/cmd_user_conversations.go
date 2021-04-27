package main

import (
	"context"
	"flag"
	"fmt"
	"net/http"
	"strconv"
)

type userConversations struct {
	Types           string
	IncludeArchived bool
	Limit           int
	Cursor          string
}

type userConversationsResponse struct {
	Ok    bool   `json:"ok"`
	Error string `json:"error"`

	ResponseMetadata struct {
		NextCursor string `json:"next_cursor"`
	} `json:"response_metadata"`

	Channels []Channel `json:"channels"`
}

func (r userConversationsResponse) Items() []fmt.Stringer {
	items := make([]fmt.Stringer, len(r.Channels))
	for i := 0; i < len(r.Channels); i++ {
		items[i] = &r.Channels[i]
	}
	return items
}

func (r userConversationsResponse) NextCursor() string {
	return r.ResponseMetadata.NextCursor
}

func (c *userConversations) Parse(args []string) error {
	s := flag.NewFlagSet("channels", flag.ExitOnError)
	s.StringVar(&c.Types, "types", "public_channel,private_channel", "")
	s.BoolVar(&c.IncludeArchived, "include-archived", false, "")
	s.IntVar(&c.Limit, "limit", 10, "")
	s.StringVar(&c.Cursor, "cursor", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *userConversations) NewRequest(ctx context.Context) (*http.Request, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://slack.com/api/users.conversations", nil)

	vals := req.URL.Query()
	vals.Add("types", c.Types)
	vals.Add("exclude_archived", strconv.FormatBool(!c.IncludeArchived))

	vals.Add("limit", strconv.Itoa(c.Limit))

	if len(c.Cursor) > 0 {
		vals.Add("cursor", c.Cursor)
	}

	req.URL.RawQuery = vals.Encode()

	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	return req, nil
}

func (c *userConversations) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv userConversationsResponse

	return handleListResponse(ctx, resp, &resv)
}
