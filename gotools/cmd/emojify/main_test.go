package main

import (
	"bytes"
	_ "embed"
	"io"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func Test_emojiDict_SplitFunc(t *testing.T) {
	t.Parallel()

	type args struct {
		data  []byte
		atEOF bool
	}

	tests := []struct {
		name        string
		e           emojiDict
		args        args
		wantAdvance int
		wantToken   []byte
		wantErr     bool
		wantNext    []byte
	}{
		{
			e: map[string][]byte{"smile": []byte("😄")},
			args: args{
				data:  []byte("hello world :smile:"),
				atEOF: true,
			},
			wantAdvance: 12,
			wantToken:   []byte("hello world "),
			wantNext:    []byte(":smile:"),
		},
		{
			e: map[string][]byte{"smile": []byte("😄")},
			args: args{
				data:  []byte(":smile: hello world"),
				atEOF: false,
			},
			wantAdvance: 7,
			wantToken:   []byte("😄"),
			wantNext:    []byte(" hello world"),
		},
		{
			e: map[string][]byte{"smile": []byte("😄")},
			args: args{
				data:  []byte(":smile1:smile:"),
				atEOF: false,
			},
			wantAdvance: 7,
			wantToken:   []byte(":smile1"),
			wantNext:    []byte(":smile:"),
		},
		{
			e: map[string][]byte{"smile": []byte("😄")},
			args: args{
				data:  []byte(": :smile:"),
				atEOF: false,
			},
			wantAdvance: 2,
			wantToken:   []byte(": "),
			wantNext:    []byte(":smile:"),
		},
		{
			e: map[string][]byte{"smile": []byte("😄")},
			args: args{
				data:  []byte(":smile :"),
				atEOF: false,
			},
			wantAdvance: 7,
			wantToken:   []byte(":smile "),
			wantNext:    []byte(":"),
		},
	}

	for _, tt := range tests {
		tt := tt

		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			gotAdvance, gotToken, err := tt.e.SplitFunc(tt.args.data, tt.args.atEOF)
			if tt.wantErr {
				assert.Error(t, err, tt.name)

				return
			}

			assert.Equal(t, gotAdvance, tt.wantAdvance, tt.name)
			assert.Equal(t, gotToken, tt.wantToken, tt.name)
			assert.Equal(t, tt.args.data[gotAdvance:], tt.wantNext, tt.name)
		})
	}
}

func Test_run(t *testing.T) {
	t.Parallel()

	type args struct {
		r io.Reader
	}
	tests := []struct {
		name    string
		args    args
		wantW   string
		wantErr bool
	}{
		{
			args:  args{r: strings.NewReader("hello")},
			wantW: "hello",
		},
		{
			args:  args{r: strings.NewReader(":smile:")},
			wantW: "😄",
		},
		{
			args:  args{r: strings.NewReader(":smile1:smile:")},
			wantW: ":smile1😄",
		},
		{
			args:  args{r: strings.NewReader(":smile:smile:")},
			wantW: "😄smile:",
		},
	}
	for _, tt := range tests {
		tt := tt

		t.Run(tt.name, func(t *testing.T) {
			t.Parallel()

			w := &bytes.Buffer{}
			err := run(w, tt.args.r)
			if tt.wantErr {
				assert.Error(t, err, tt.name)

				return
			}

			assert.Equal(t, w.String(), tt.wantW, tt.name)
		})
	}
}
