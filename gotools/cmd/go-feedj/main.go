package main

import (
	"encoding/json"
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

func feed2json(w io.Writer, r io.Reader) error {
	fp := gofeed.NewParser()

	feed, err := fp.Parse(r)
	if err != nil {
		return err
	}

	for _, item := range feed.Items {
		if err := json.NewEncoder(w).Encode(item); err != nil {
			return err
		}
	}

	return nil
}
