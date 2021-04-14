package main

import (
	"strings"
	"testing"
)

func Test_resolve(t *testing.T) {
	for _, tt := range []struct {
		name, input, expected string
	}{
		{{- range $i, $v := .SampleTestCase }}
		{
			name: "sample-{{ $i }}",
			input: `{{ $v.Input }}`,
			expected: `{{ $v.Output }}`,
		},
		{{- end }}
	} {
		t.Run(tt.name, func(t *testing.T) {
			actual := resolve(strings.NewReader(tt.input))
			if tt.expected != actual {
				t.Errorf("needs %s but got %s", tt.expected, actual)
			}
		})
	}
}