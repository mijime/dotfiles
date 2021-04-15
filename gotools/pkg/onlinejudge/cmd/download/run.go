package download

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"os"
	"path"
	"strings"
	"text/template"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type fetchContestAPI interface {
	FetchContest(ctx context.Context, contestID string) (onlinejudge.Contest, error)
}

type fetchProblemAPI interface {
	FetchProblem(ctx context.Context, problemID string) (onlinejudge.Problem, error)
}

type Command struct {
	templatePath string
	contestID    string
	problemID    string
}

var errNotSupportedAPI = errors.New("not supported api")

func (cmd *Command) NewFlagSet() *flag.FlagSet {
	fs := flag.NewFlagSet("download", flag.ExitOnError)
	fs.StringVar(&cmd.templatePath, "template", path.Join(os.Getenv("HOME"), ".config", "gojt", "templates", "**.tpl"), "")
	fs.StringVar(&cmd.contestID, "contest", "", "")
	fs.StringVar(&cmd.problemID, "problem", "", "")

	return fs
}

func (cmd *Command) Execute(orgAPI onlinejudge.API) error {
	ctx := context.Background()

	if api, ok := orgAPI.(fetchProblemAPI); ok && len(cmd.problemID) > 0 {
		p, err := api.FetchProblem(ctx, cmd.problemID)
		if err != nil {
			return fmt.Errorf("failed to fetch problem: %w", err)
		}

		return cmd.generateProblem(p, ".")
	}

	if api, ok := orgAPI.(fetchContestAPI); ok && len(cmd.contestID) > 0 {
		c, err := api.FetchContest(ctx, cmd.contestID)
		if err != nil {
			return fmt.Errorf("failed to fetch contest: %w", err)
		}

		return cmd.generateContest(c)
	}

	return errNotSupportedAPI
}

func (cmd *Command) generateContest(c onlinejudge.Contest) error {
	for id, p := range c.Problems {
		if err := cmd.generateProblem(p, id); err != nil {
			return err
		}
	}

	return nil
}

func (cmd *Command) generateProblem(p onlinejudge.Problem, dir string) error {
	tmplfiles, err := template.ParseGlob(cmd.templatePath)
	if err != nil {
		return fmt.Errorf("failed to parse template: %w", err)
	}

	for _, tmpl := range tmplfiles.Templates() {
		filepath := dir + "/" + tmpl.Name()

		if err := os.MkdirAll(path.Dir(filepath), os.ModePerm); err != nil {
			return fmt.Errorf("failed to make directory: %w", err)
		}

		fp, err := os.Create(strings.TrimSuffix(filepath, ".tpl"))
		if err != nil {
			return fmt.Errorf("failed to create file: %w", err)
		}

		if err := tmpl.Execute(fp, p); err != nil {
			return fmt.Errorf("failed to execute template: %w", err)
		}
	}

	return nil
}
