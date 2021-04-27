package main

import (
	"errors"
	"time"
)

type TimeVar struct {
	time.Time
}

func (t *TimeVar) String() string {
	if t == nil {
		return ""
	}

	return t.Format(time.RFC3339)
}

func (t *TimeVar) Set(v string) error {
	if t == nil {
		return nil
	}

	d, err := time.ParseDuration(v)
	if err == nil {
		t.Time = time.Now().Add(d)

		return nil
	}

	for _, layout := range []string{
		time.UnixDate,
		time.RFC1123,
		time.RFC3339,
		time.RFC822,
		time.RFC850,
	} {
		tp, err := time.Parse(layout, v)
		if err != nil {
			continue
		}

		t.Time = tp
	}

	return errors.New("failed to parse time layout")
}
