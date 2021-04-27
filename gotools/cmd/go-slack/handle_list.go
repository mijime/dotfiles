package main

import (
	"bufio"
	"context"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"

	"golang.org/x/sync/errgroup"
)

type listResponse interface {
	Items() []fmt.Stringer
	NextCursor() string
}

func handleListResponse(ctx context.Context, resp *http.Response, resv listResponse) error {
	out := bufio.NewWriter(os.Stdout)
	defer out.Flush()

	var errResv errorResponse

	er, ew := io.Pipe()

	eg := &errgroup.Group{}
	eg.Go(func() error {
		if err := json.NewDecoder(io.TeeReader(resp.Body, ew)).Decode(&resv); err != nil {
			return fmt.Errorf("failed to decode response: %w", err)
		}

		return nil
	})
	eg.Go(func() error {
		if err := json.NewDecoder(er).Decode(&errResv); err != nil {
			return fmt.Errorf("failed to decode error response: %w", err)
		}

		return nil
	})

	if err := eg.Wait(); err != nil {
		return fmt.Errorf("failed to decode: %w", err)
	}

	if !errResv.Ok {
		return fmt.Errorf("failed to do request: %w", errResv)
	}

	for _, item := range resv.Items() {
		if _, err := fmt.Fprintln(out, item); err != nil {
			return fmt.Errorf("failed to print response: %w", err)
		}
	}

	nextCursor := resv.NextCursor()
	if len(nextCursor) > 0 {
		if _, err := fmt.Fprintf(out, "__NEXT__\t%s\n", nextCursor); err != nil {
			return fmt.Errorf("failed to print next cursor: %w", err)
		}
	}

	return nil
}
