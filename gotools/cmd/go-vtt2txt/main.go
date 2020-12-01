package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"time"

	astisub "github.com/asticode/go-astisub"
)

func main() {
	var talkDistance time.Duration

	const DefaultTalkDistance = 500 * time.Millisecond

	flag.DurationVar(&talkDistance, "talk", DefaultTalkDistance, "")
	flag.Parse()

	err := vtt2txt(os.Stdout, os.Stdin, talkDistance)
	if err != nil {
		log.Fatal(err)
	}
}

func vtt2txt(out io.Writer, in io.Reader, talkDistance time.Duration) error {
	vtt, err := astisub.ReadFromWebVTT(bufio.NewReader(in))
	if err != nil {
		return fmt.Errorf("failed to read from vtt: %w", err)
	}

	w := bufio.NewWriter(out)

	var prevEndedAt time.Duration

	for _, item := range vtt.Items {
		if (item.StartAt - prevEndedAt) >= talkDistance {
			if err := w.WriteByte('\n'); err != nil {
				return fmt.Errorf("failed to write buffer: %w", err)
			}
		}

		for _, line := range item.Lines {
			_, err := w.WriteString(line.String())
			if err != nil {
				return fmt.Errorf("failed to write buffer: %w", err)
			}

			if err := w.WriteByte('\n'); err != nil {
				return fmt.Errorf("failed to write buffer: %w", err)
			}
		}

		if err := w.Flush(); err != nil {
			return fmt.Errorf("failed to flush buffer: %w", err)
		}

		prevEndedAt = item.EndAt
	}

	return nil
}
