package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/jaytaylor/html2text"
)

func main() {
	opts := html2text.Options{}

	flag.BoolVar(&opts.PrettyTables, "pretty-table", opts.PrettyTables, "")
	flag.BoolVar(&opts.OmitLinks, "omit-links", opts.OmitLinks, "")
	flag.Parse()

	text, err := html2text.FromReader(os.Stdin, opts)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Fprintln(os.Stdout, text)
}
