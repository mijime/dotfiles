package main

import (
	"testing"
	"time"
)

func TestTimeVar_Set(t *testing.T) {
	type fields struct {
		Time time.Time
	}
	type args struct {
		v string
	}
	tests := []struct {
		name    string
		fields  fields
		args    args
		want    time.Time
		wantErr bool
	}{
		{
			args: args{v: "2021-05-12T19:30:33+09:00"},
			want: time.Date(2021, 5, 12, 19, 30, 33, 0, time.FixedZone("JST", 60*60*9)),
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			tr := &TimeVar{
				Time: tt.fields.Time,
			}
			if err := tr.Set(tt.args.v); (err != nil) != tt.wantErr {
				t.Errorf("TimeVar.Set() error = %v, wantErr %v", err, tt.wantErr)
			}
			if !tr.Time.Equal(tt.want) {
				t.Errorf("TimeVar.Set() got = %v, want %v", tr.Time, tt.want)
			}
		})
	}
}
