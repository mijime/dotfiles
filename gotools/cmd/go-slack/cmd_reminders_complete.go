package main

import (
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
)

type remindersComplete struct {
	Reminder string
}

type remindersCompleteRequest struct {
	Reminder string `json:"reminder"`
}

type remindersCompleteResponse struct {
	Reminder `json:"reminder"`
}

func (r remindersCompleteResponse) Item() fmt.Stringer {
	return r.Reminder
}

func (c *remindersComplete) Parse(args []string) error {
	s := flag.NewFlagSet("reminders", flag.ExitOnError)
	s.StringVar(&c.Reminder, "reminder", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *remindersComplete) NewRequest(ctx context.Context) (*http.Request, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, "https://slack.com/api/reminders.complete", nil)

	var reqv remindersCompleteRequest
	reqv.Reminder = c.Reminder

	buf := bytes.NewBuffer([]byte{})

	if err := json.NewEncoder(buf).Encode(reqv); err != nil {
		return nil, fmt.Errorf("failed to encode request body: %w", err)
	}

	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Add("Content-type", "application/json")

	return req, nil
}

func (c *remindersComplete) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv remindersCompleteResponse

	return handlePostResponse(ctx, resp, &resv)
}
