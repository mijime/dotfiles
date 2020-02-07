package main

import (
	"flag"
	"log"
	"net/http"
	"net/http/httputil"
	"net/url"
)

func main() {
	var (
		addr   string
		target string
	)

	flag.StringVar(&addr, "addr", ":3000", "")
	flag.StringVar(&target, "target", "http://localhost:8080", "")
	flag.Parse()

	u, err := url.Parse(target)
	if err != nil {
		log.Fatalf("%+v", err)
	}

	svc := http.Server{
		Addr:    addr,
		Handler: httputil.NewSingleHostReverseProxy(u),
	}

	if err := svc.ListenAndServe(); err != nil {
		log.Fatalf("%+v", err)
	}
}
