package main

import (
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
	"os"
)

type reactionsAdd struct {
	Channel   string
	Timestamp string
	Emoji     string
}

type reactionsAddRequest struct {
	Channel   string `json:"channel"`
	Timestamp string `json:"timestamp"`
	Name      string `json:"name"`
}

type reactionsAddResponse struct{}

func (c *reactionsAdd) Parse(args []string) error {
	s := flag.NewFlagSet("reaction", flag.ExitOnError)
	s.StringVar(&c.Channel, "channel", os.Getenv("SLACK_CHANNEL"), "")
	s.StringVar(&c.Timestamp, "timestamp", "", "")
	s.StringVar(&c.Emoji, "emoji", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *reactionsAdd) NewRequest(ctx context.Context) (*http.Request, error) {
	var reqv reactionsAddRequest
	reqv.Channel = c.Channel
	reqv.Timestamp = c.Timestamp
	reqv.Name = c.Emoji

	buf := bytes.NewBuffer([]byte{})

	if err := json.NewEncoder(buf).Encode(reqv); err != nil {
		return nil, fmt.Errorf("failed to encode request body: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, "https://slack.com/api/reactions.add", buf)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Add("Content-type", "application/json")

	return req, nil
}

func (c *reactionsAdd) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv reactionsAddResponse

	return handlePostResponse(ctx, resp, &resv)
}
