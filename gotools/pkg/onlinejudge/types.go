package onlinejudge

import (
	"flag"
	"io"
)

type Contest struct {
	Problems map[string]Problem
}

type Problem struct {
	Text           string
	SampleTestCase []TestCase
}

type TestCase struct {
	Input  string
	Output string
}

type SubmitInput struct {
	ProblemID string
	Lang      string
	File      io.Reader
}

type Submission struct {
	ProblemID string
	Status    string
}

type SubmissionsInput struct {
	ContestID string
}

type API interface{}

type Command interface {
	NewFlagSet() *flag.FlagSet
	Execute(API) error
}
