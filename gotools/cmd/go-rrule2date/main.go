package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"time"

	rrule "github.com/teambition/rrule-go"
)

func main() {
	var startedAt, endedAt TimeVar
	var rruleText, layout string

	flag.Var(&startedAt, "started", "")
	flag.Var(&endedAt, "ended", "")
	flag.StringVar(&rruleText, "rrule", "", "")
	flag.StringVar(&layout, "layout", time.RFC3339, "")
	flag.Parse()

	a := Application{
		StartedAt: startedAt.Time,
		EndedAt:   endedAt.Time,
		RRuleText: rruleText,
		Layout:    layout,
	}

	it, err := a.IterDate()
	if err != nil {
		log.Fatal(err)
	}

	for {
		tv, ok := it()
		if !ok {
			break
		}

		if _, err := fmt.Fprintln(os.Stdout, tv.Format(a.Layout)); err != nil {
			log.Fatal(err)
		}
	}
}

type Application struct {
	StartedAt, EndedAt time.Time
	RRuleText          string
	Layout             string
}

var defaultTime = time.Date(1, 1, 1, 0, 0, 0, 0, time.UTC)

func (a Application) IterDate() (rrule.Next, error) {
	got, err := rrule.StrToRRule(a.RRuleText)
	if err != nil {
		return nil, err
	}

	if !defaultTime.Equal(a.StartedAt) {
		got.DTStart(a.StartedAt)
	}

	if !defaultTime.Equal(a.EndedAt) {
		got.Until(a.EndedAt)
	}

	return got.Iterator(), nil
}

func parseDate(v string) (time.Time, error) {
	var latestErr error

	for _, layout := range []string{
		time.Layout,
		time.RFC1123,
		time.RFC3339,
		time.RFC822,
		time.RFC850,
	} {
		t, err := time.Parse(layout, v)
		if err != nil {
			latestErr = err
			continue
		}
		return t, nil
	}

	return time.Now(), latestErr
}

type TimeVar struct {
	time.Time
}

func (d *TimeVar) String() string {
	return d.Format(time.RFC3339)
}

func (d *TimeVar) Set(v string) error {
	tv, err := parseDate(v)
	if err != nil {
		return err
	}

	d.Time = tv

	return nil
}
