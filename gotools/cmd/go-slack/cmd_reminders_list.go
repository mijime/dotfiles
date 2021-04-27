package main

import (
	"context"
	"flag"
	"fmt"
	"net/http"
	"strconv"
)

type remindersListResponse struct {
	ResponseMetadata struct {
		NextCursor string `json:"next_cursor"`
	} `json:"response_metadata"`

	Reminders []Reminder `json:"reminders"`
}

func (r remindersListResponse) Items() []fmt.Stringer {
	items := make([]fmt.Stringer, len(r.Reminders))
	for i := 0; i < len(r.Reminders); i++ {
		items[i] = &r.Reminders[i]
	}
	return items
}

func (r remindersListResponse) NextCursor() string {
	return r.ResponseMetadata.NextCursor
}

type remindersList struct {
	Limit  int
	Cursor string
}

func (c *remindersList) Parse(args []string) error {
	s := flag.NewFlagSet("reminders", flag.ExitOnError)
	s.IntVar(&c.Limit, "limit", 10, "")
	s.StringVar(&c.Cursor, "cursor", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *remindersList) NewRequest(ctx context.Context) (*http.Request, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, "https://slack.com/api/reminders.list", nil)

	vals := req.URL.Query()
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

func (c *remindersList) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv remindersListResponse

	return handleListResponse(ctx, resp, &resv)
}
