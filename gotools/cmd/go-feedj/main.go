package main

import (
	"encoding/json"
	"fmt"
	"io"
	"log"
	"os"

	"github.com/mmcdole/gofeed"
)

func main() {
	err := feed2json(os.Stdout, os.Stdin)
	if err != nil {
		log.Fatal(err)
	}
}

func feed2json(out io.Writer, in io.Reader) error {
	fp := gofeed.NewParser()

	feed, err := fp.Parse(in)
	if err != nil {
		return fmt.Errorf("failed to parse feed: %w", err)
	}

	enc := json.NewEncoder(out)

	for _, item := range feed.Items {
		if err := enc.Encode(item); err != nil {
			return fmt.Errorf("failed to encode json: %w", err)
		}
	}

	return nil
}
