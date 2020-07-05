package main

import (
	"bufio"
	"encoding/csv"
	"encoding/json"
	"io"
	"log"
	"os"
)

func main() {
	in := os.Stdin
	out := os.Stdout

	r := csv.NewReader(bufio.NewReader(in))
	w := bufio.NewWriter(out)

	defer w.Flush()

	enc := json.NewEncoder(w)

	header, err := r.Read()
	if err != nil {
		log.Fatal(err)
	}

	for {
		record, err := r.Read()
		if err == io.EOF {
			break
		}

		if err != nil {
			log.Fatal(err)
		}

		dict := make(map[string]string)
		for i, d := range record {
			dict[header[i]] = d
		}

		if err := enc.Encode(dict); err != nil {
			log.Fatal(err)
		}
	}
}
