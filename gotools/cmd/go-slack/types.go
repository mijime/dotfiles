package main

import (
	"strconv"
	"strings"
	"time"
)

type Reminder struct {
	ID           string `json:"id"`
	Creator      string `json:"creator"`
	User         string `json:"user"`
	Text         string `json:"text"`
	Time         int64  `json:"time"`
	CompleteTime int64  `json:"complete_ts"`
	Recurring    bool   `json:"recurring"`
}

func (r Reminder) String() string {
	status := "INBOX"
	if r.CompleteTime > 0 {
		status = "DONE:" + time.Unix(r.CompleteTime, 0).Format(time.RFC3339)
	}

	return strings.Join([]string{
		r.ID,
		r.Text,
		time.Unix(r.Time, 0).Format(time.RFC3339),
		status,
	}, "\t")
}

type Channel struct {
	ID   string `json:"id"`
	Name string `json:"name"`
}

func (r Channel) String() string {
	return strings.Join([]string{
		r.ID,
		r.Name,
	}, "\t")
}

type Message struct {
	Timestamp  string `json:"ts"`
	User       string `json:"user"`
	Text       string `json:"text"`
	ReplyCount int    `json:"reply_count"`
	Reactions  []struct {
		Count int      `json:"count"`
		Name  string   `json:"name"`
		Users []string `json:"users"`
	} `json:"reactions"`
}

func (r Message) String() string {
	return strings.Join([]string{
		r.Timestamp,
		r.User,
		strconv.Itoa(r.ReplyCount),
		r.Text,
	}, "\t")
}
