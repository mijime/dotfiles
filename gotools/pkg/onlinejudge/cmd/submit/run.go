package submit

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"io/fs"
	"os"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type submitAPI interface {
	Submit(ctx context.Context, input onlinejudge.SubmitInput) error
}

type Command struct {
	file      argsFile
	lang      string
	problemID string
}

type argsFile struct {
	fs.File
}

func (a *argsFile) String() string {
	return ""
}

func (a *argsFile) Set(v string) error {
	fp, err := os.Open(v)
	if err != nil {
		return err
	}

	a.File = fp

	return nil
}

var errNotSupportedAPI = errors.New("not supoorted api")

func (cmd *Command) NewFlagSet() *flag.FlagSet {
	fs := flag.NewFlagSet("submit", flag.ExitOnError)
	fs.Var(&cmd.file, "f", "")
	fs.Var(&cmd.file, "file", "")
	fs.StringVar(&cmd.lang, "l", os.Getenv("GOJT_LANG"), "")
	fs.StringVar(&cmd.lang, "lang", os.Getenv("GOJT_LANG"), "")
	fs.StringVar(&cmd.problemID, "p", "", "")
	fs.StringVar(&cmd.problemID, "problem", "", "")

	return fs
}

func (cmd *Command) Execute(orgAPI onlinejudge.API) error {
	if cmd.file.File == nil {
		return errors.New("require file")
	}

	if len(cmd.problemID) == 0 {
		return errors.New("require problem id")
	}

	if len(cmd.lang) == 0 {
		return errors.New("require language")
	}

	defer cmd.file.Close()

	if api, ok := orgAPI.(submitAPI); ok {
		ctx := context.Background()

		if err := api.Submit(ctx, onlinejudge.SubmitInput{
			ProblemID: cmd.problemID,
			File:      cmd.file,
			Lang:      cmd.lang,
		}); err != nil {
			return fmt.Errorf("failed to submit: %w", err)
		}

		return nil
	}

	return errNotSupportedAPI
}
