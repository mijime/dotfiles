package main

import (
	"testing"
	"time"

	"github.com/stretchr/testify/assert"
)

func parseTimeMust(layout, v string) time.Time {
	tv, _ := time.Parse(layout, v)
	return tv
}

func TestApplication_IterDate(t *testing.T) {
	type fields struct {
		StartedAt time.Time
		EndedAt   time.Time
		RRuleText string
		Layout    string
	}
	tests := []struct {
		name    string
		fields  fields
		want    []time.Time
		wantErr bool
	}{
		{
			fields: fields{
				StartedAt: parseTimeMust(time.RFC3339, "2021-04-01T17:30:00+09:00"),
				EndedAt:   parseTimeMust(time.RFC3339, "2021-04-01T18:00:00+09:00"),
				RRuleText: "FREQ=WEEKLY;BYDAY=TH",
				Layout:    time.RFC3339,
			},
			want: []time.Time{
				parseTimeMust(time.RFC3339, "2021-04-01T17:30:00+09:00"),
			},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			a := Application{
				StartedAt: tt.fields.StartedAt,
				EndedAt:   tt.fields.EndedAt,
				RRuleText: tt.fields.RRuleText,
				Layout:    tt.fields.Layout,
			}
			got, err := a.IterDate()
			if (err != nil) != tt.wantErr {
				t.Errorf("Application.IterDate() error = %v, wantErr %v", err, tt.wantErr)
				return
			}

			actual := make([]time.Time, 0)
			for {
				tv, ok := got()
				if !ok {
					break
				}

				actual = append(actual, tv)
			}

			assert.Equal(t, actual, tt.want)
		})
	}
}
