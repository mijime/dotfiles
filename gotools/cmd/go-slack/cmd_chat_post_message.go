package main

import (
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"io"
	"net/http"
	"os"
)

type chatPostMessage struct {
	Channel   string `json:"channel"`
	Timestamp string `json:"thread_ts"`
	Text      string `json:"text"`
}

type chatPostMessageResponse struct{}

func (c *chatPostMessage) Parse(args []string) error {
	s := flag.NewFlagSet("post", flag.ExitOnError)
	s.StringVar(&c.Channel, "channel", os.Getenv("SLACK_CHANNEL"), "")
	s.StringVar(&c.Timestamp, "timestamp", "", "")
	s.StringVar(&c.Text, "text", "", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *chatPostMessage) NewRequest(ctx context.Context) (*http.Request, error) {
	if len(c.Text) == 0 {
		b, err := io.ReadAll(os.Stdin)
		if err != nil {
			return nil, fmt.Errorf("failed to read text: %w", err)
		}

		c.Text = string(b)
	}

	buf := bytes.NewBuffer([]byte{})

	if err := json.NewEncoder(buf).Encode(c); err != nil {
		return nil, fmt.Errorf("failed to encode request body: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, "https://slack.com/api/chat.postMessage", buf)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Add("Content-type", "application/json")

	return req, nil
}

func (c *chatPostMessage) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv chatPostMessageResponse

	return handlePostResponse(ctx, resp, &resv)
}
