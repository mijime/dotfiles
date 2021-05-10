package main

import (
	"context"
	"flag"
	"fmt"
	"net/http"
	"os"
	"strconv"
)

type conversationsHistory struct {
	Channel string

	Limit  int
	Cursor string
}

type conversationsHistoryResponse struct {
	ResponseMetadata struct {
		NextCursor string `json:"next_cursor"`
	} `json:"response_metadata"`

	Messages []Message `json:"messages"`
}

func (r conversationsHistoryResponse) Items() []fmt.Stringer {
	items := make([]fmt.Stringer, len(r.Messages))
	for i := 0; i < len(r.Messages); i++ {
		items[i] = &r.Messages[i]
	}
	return items
}

func (r conversationsHistoryResponse) NextCursor() string {
	return r.ResponseMetadata.NextCursor
}

func (c *conversationsHistory) Parse(args []string) error {
	s := flag.NewFlagSet("messages", flag.ExitOnError)
	s.StringVar(&c.Channel, "channel", os.Getenv("SLACK_CHANNEL"), "")
	s.IntVar(&c.Limit, "limit", 10, "")
	s.StringVar(&c.Cursor, "cursor", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *conversationsHistory) NewRequest(ctx context.Context) (*http.Request, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://slack.com/api/conversations.history", nil)

	vals := req.URL.Query()
	vals.Add("channel", c.Channel)
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

func (c *conversationsHistory) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv conversationsHistoryResponse

	return handleListResponse(ctx, resp, &resv)
}
