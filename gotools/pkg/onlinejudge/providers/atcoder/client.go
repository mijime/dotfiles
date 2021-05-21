package atcoder

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"net/http/cookiejar"
	"net/url"
	"os"
	"path"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type Client struct {
	*API
}

func NewClient() (*Client, error) {
	jar, err := cookiejar.New(nil)
	if err != nil {
		return nil, fmt.Errorf("faield to initialize cookie: %w", err)
	}

	httpClient := &http.Client{Jar: jar}
	client := &Client{API: &API{Client: httpClient}}

	u, err := url.Parse("https://atcoder.jp")
	if err != nil {
		log.Printf("failed to parse url: %s", err)

		return client, nil
	}

	fp, err := os.Open(path.Join(os.Getenv("HOME"), ".config", "gojt", "cookies", "atcoder.json"))
	if err != nil {
		log.Printf("failed to open cookie file: %s", err)

		return client, nil
	}
	defer fp.Close()

	cookies := make([]*http.Cookie, 0)
	if err := json.NewDecoder(fp).Decode(&cookies); err != nil {
		log.Printf("failed to decode cookie file: %s", err)

		return client, nil
	}

	httpClient.Jar.SetCookies(u, cookies)

	return client, nil
}

func (c *Client) Close() error {
	u, err := url.Parse("https://atcoder.jp")
	if err != nil {
		return fmt.Errorf("failed to parse url: %w", err)
	}

	if err := os.MkdirAll(path.Join(os.Getenv("HOME"), ".config", "gojt", "cookies"), os.ModePerm); err != nil {
		return fmt.Errorf("failed to create cookies dir: %w", err)
	}

	fp, err := os.Create(path.Join(os.Getenv("HOME"), ".config", "gojt", "cookies", "atcoder.json"))
	if err != nil {
		return fmt.Errorf("failed to create cookie file: %w", err)
	}
	defer fp.Close()

	cookies := c.Jar.Cookies(u)

	if err := json.NewEncoder(fp).Encode(cookies); err != nil {
		return fmt.Errorf("failed to encode cookie file: %w", err)
	}

	return nil
}

func (c *Client) FetchContest(ctx context.Context, contestID string) (onlinejudge.Contest, error) {
	defer func() {
		err := c.Close()
		if err != nil {
			log.Printf("failed to close: %s", err)
		}
	}()

	return c.API.FetchContest(ctx, contestID)
}

func (c *Client) FetchProblem(ctx context.Context, problemID string) (onlinejudge.Problem, error) {
	defer func() {
		err := c.Close()
		if err != nil {
			log.Printf("failed to close: %s", err)
		}
	}()

	return c.API.FetchProblem(ctx, problemID)
}

func (c *Client) LoginUseUsernameAndPassword(ctx context.Context, username, password string) error {
	defer func() {
		err := c.Close()
		if err != nil {
			log.Printf("failed to close: %s", err)
		}
	}()

	return c.API.LoginUseUsernameAndPassword(ctx, username, password)
}
