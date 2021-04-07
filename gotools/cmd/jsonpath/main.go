package main

import (
	"encoding/json"
	"flag"
	"log"
	"os"

	"k8s.io/client-go/util/jsonpath"
)

func main() {
	var query string

	flag.StringVar(&query, "query", "", "")
	flag.Parse()

	j := jsonpath.New("jsonpath")

	if err := j.Parse("{" + query + "}\n"); err != nil {
		log.Fatal(err)
	}

	var data interface{}
	if err := json.NewDecoder(os.Stdin).Decode(&data); err != nil {
		log.Fatal(err)
	}

	if err := j.Execute(os.Stdout, data); err != nil {
		log.Fatal(err)
	}
}
