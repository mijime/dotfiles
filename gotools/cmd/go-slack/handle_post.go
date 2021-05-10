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

type postResponse interface {
	Item() fmt.Stringer
}

func handlePostResponse(ctx context.Context, resp *http.Response, resv interface{}) error {
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

	postResv, ok := resv.(postResponse)
	if !ok {
		return nil
	}

	if _, err := fmt.Fprintln(out, postResv.Item()); err != nil {
		return fmt.Errorf("failed to print response: %w", err)
	}

	return nil
}
