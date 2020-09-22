package main

import (
	"bufio"
	"encoding/csv"
	"encoding/json"
	"io"
	"log"
	"os"
)

func csv2json(in io.Reader, out io.Writer) error {
	r := csv.NewReader(bufio.NewReader(in))

	header, err := r.Read()
	if err != nil {
		return err
	}

	w := bufio.NewWriter(out)

	defer w.Flush()

	enc := json.NewEncoder(w)

	for {
		record, err := r.Read()
		if err == io.EOF {
			break
		}

		if err != nil {
			return err
		}

		dict := make(map[string]string)
		for i, d := range record {
			dict[header[i]] = d
		}

		if err := enc.Encode(dict); err != nil {
			return err
		}
	}

	return nil
}

func main() {
	in := os.Stdin
	out := os.Stdout

	err := csv2json(in, out)
	if err != nil {
		log.Fatal(err)
	}
}
