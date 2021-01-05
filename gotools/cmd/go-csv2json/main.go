package main

import (
	"bufio"
	"encoding/csv"
	"encoding/json"
	"errors"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
)

func main() {
	var quiet bool

	flag.BoolVar(&quiet, "quiet", false, "")
	flag.Parse()

	ctx := context{
		Quiet: quiet,
	}

	err := ctx.csv2json(os.Stdout, os.Stdin)
	if err != nil {
		log.Fatal(err)
	}
}

type context struct {
	Quiet bool
}

func (ctx context) csv2json(out io.Writer, in io.Reader) error {
	r := csv.NewReader(bufio.NewReader(in))

	header, err := r.Read()
	if err != nil {
		return fmt.Errorf("failed to read csv: %w", err)
	}

	w := bufio.NewWriter(out)
	defer w.Flush()

	enc := json.NewEncoder(w)

	for {
		record, err := r.Read()
		if errors.Is(err, io.EOF) {
			break
		}

		if err != nil {
			return fmt.Errorf("failed to read csv: %w", err)
		}

		dict := make(map[string]string)

		for i, d := range record {
			if ctx.Quiet && len(d) == 0 {
				continue
			}

			dict[header[i]] = d
		}

		if err := enc.Encode(dict); err != nil {
			return fmt.Errorf("failed to encode json: %w", err)
		}
	}

	return nil
}
