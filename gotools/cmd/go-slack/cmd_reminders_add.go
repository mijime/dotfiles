package main

import (
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
)

type remindersAdd struct {
	Time TimeVar
	Text string
	User string
}

type remindersAddRequest struct {
	Time int64  `json:"time"`
	Text string `json:"text"`
	User string `json:"user"`
}

type remindersAddResponse struct {
	Reminder `json:"reminder"`
}

func (r remindersAddResponse) Item() fmt.Stringer {
	return r.Reminder
}

func (c *remindersAdd) Parse(args []string) error {
	s := flag.NewFlagSet("reaction", flag.ExitOnError)
	s.Var(&c.Time, "time", "")
	s.StringVar(&c.Text, "text", "", "")
	s.StringVar(&c.User, "user", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *remindersAdd) NewRequest(ctx context.Context) (*http.Request, error) {
	var reqv remindersAddRequest
	unixtime := c.Time.Unix()
	if unixtime > 0 {
		reqv.Time = unixtime
	}
	reqv.Text = c.Text
	reqv.User = c.User

	buf := bytes.NewBuffer([]byte{})

	if err := json.NewEncoder(buf).Encode(reqv); err != nil {
		return nil, fmt.Errorf("failed to encode request body: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, "https://slack.com/api/reminders.add", buf)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Add("Content-type", "application/json")

	return req, nil
}

func (c *remindersAdd) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv remindersAddResponse

	return handlePostResponse(ctx, resp, &resv)
}
