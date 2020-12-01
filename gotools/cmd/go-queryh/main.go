package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"os"

	"github.com/PuerkitoBio/goquery"
)

func main() {
	var (
		query string
		attr  string
	)

	flag.StringVar(&query, "query", "", "")
	flag.StringVar(&attr, "attr", "html", "")
	flag.Parse()

	err := queryHTML(os.Stdout, os.Stdin, query, attr)
	if err != nil {
		log.Fatal(err)
	}
}

func queryHTML(out io.Writer, in io.Reader, query, attr string) error {
	doc, err := goquery.NewDocumentFromReader(in)
	if err != nil {
		return fmt.Errorf("failed to read html: %w", err)
	}

	doc.Find(query).Each(func(i int, s *goquery.Selection) {
		switch attr {
		case "text":
			fmt.Fprintln(out, s.Text())

		case "html":
			res, err := s.Html()
			if err != nil {
				log.Println(err)

				return
			}

			fmt.Fprintln(out, res)

		default:
			res, ok := s.Attr(attr)
			if ok {
				fmt.Fprintln(out, res)
			}
		}
	})

	return nil
}
