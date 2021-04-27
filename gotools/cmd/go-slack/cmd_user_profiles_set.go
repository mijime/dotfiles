package main

import (
	"bytes"
	"context"
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
)

type usersProfileSet struct {
	Text  string
	Emoji string
	Time  TimeVar
}

type usersProfileSetRequest struct {
	Profile struct {
		StatusText       string `json:"status_text"`
		StatusEmoji      string `json:"status_emoji"`
		StatusExpiration int64  `json:"status_expiration"`
	} `json:"profile"`
}

type usersProfileSetResponse struct {
}

func (c *usersProfileSet) Parse(args []string) error {
	s := flag.NewFlagSet("post", flag.ExitOnError)
	s.StringVar(&c.Text, "text", "", "")
	s.StringVar(&c.Emoji, "emoji", "", "")
	s.Var(&c.Time, "time", "")

	if err := s.Parse(args); err != nil {
		return fmt.Errorf("failed to parse: %w", err)
	}

	return nil
}

func (c *usersProfileSet) NewRequest(ctx context.Context) (*http.Request, error) {
	var reqv usersProfileSetRequest
	reqv.Profile.StatusText = c.Text

	if len(c.Emoji) > 0 {
		reqv.Profile.StatusEmoji = ":" + c.Emoji + ":"
	}

	unixtime := c.Time.Unix()
	if unixtime > 0 {
		reqv.Profile.StatusExpiration = unixtime
	}

	buf := bytes.NewBuffer([]byte{})

	if err := json.NewEncoder(buf).Encode(reqv); err != nil {
		return nil, fmt.Errorf("failed to encode request body: %w", err)
	}

	req, err := http.NewRequestWithContext(ctx, http.MethodPost, "https://slack.com/api/users.profile.set", buf)
	if err != nil {
		return nil, fmt.Errorf("failed to create request: %w", err)
	}

	req.Header.Add("Content-type", "application/json")

	return req, nil
}

func (c *usersProfileSet) HandleResponse(ctx context.Context, resp *http.Response) error {
	var resv usersProfileSetResponse

	return handlePostResponse(ctx, resp, &resv)
}
