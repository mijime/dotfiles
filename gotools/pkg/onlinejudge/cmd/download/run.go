package download

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"io"
	"io/fs"
	"log"
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
	contestID string
	problemID string

	templateFS *argsFS
	downloadFS *argsFS
}

type argsFS struct{ FS }

func (a *argsFS) String() string {
	return a.FS.String()
}

func (a *argsFS) Set(v string) error {
	a.FS = osFS(v)

	return nil
}

type FS interface {
	fs.StatFS
	Create(name string) (osFile, error)
	MkdirAll(name string, perm fs.FileMode) error
	fmt.Stringer
}

type osFS string

func (f osFS) Open(name string) (fs.File, error) {
	return os.Open(path.Join(string(f), name))
}

func (f osFS) Stat(name string) (fs.FileInfo, error) {
	return os.Stat(path.Join(string(f), name))
}

type osFile interface {
	fs.File
	io.WriteCloser
}

func (f osFS) Create(name string) (osFile, error) {
	return os.Create(path.Join(string(f), name))
}

func (f osFS) MkdirAll(name string, perm fs.FileMode) error {
	return os.MkdirAll(path.Join(string(f), name), perm)
}

func (f osFS) String() string {
	return string(f)
}

var errNotSupportedAPI = errors.New("not supported api")

func New() *Command {
	return &Command{
		templateFS: &argsFS{FS: osFS(path.Join(os.Getenv("HOME"), ".config", "gojt", "templates"))},
		downloadFS: &argsFS{FS: osFS(".")},
	}
}

func (cmd *Command) NewFlagSet() *flag.FlagSet {
	fs := flag.NewFlagSet("download", flag.ExitOnError)
	fs.Var(cmd.templateFS, "template", "")
	fs.Var(cmd.downloadFS, "download", "")
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
	tmplfiles, err := template.ParseFS(cmd.templateFS, "**.*")
	if err != nil {
		return fmt.Errorf("failed to parse template: %w", err)
	}

	for _, tmpl := range tmplfiles.Templates() {
		filepath := path.Join(dir, tmpl.Name())
		if _, err := cmd.downloadFS.FS.Stat(filepath); err == nil {
			log.Printf("already exists: %+v", filepath)

			continue
		}

		if err := cmd.downloadFS.MkdirAll(path.Dir(filepath), os.ModePerm); err != nil {
			return fmt.Errorf("failed to make directory: %w", err)
		}

		fp, err := cmd.downloadFS.Create(strings.TrimSuffix(filepath, ".tpl"))
		if err != nil {
			return fmt.Errorf("failed to create file: %w", err)
		}

		if err := tmpl.Execute(fp, p); err != nil {
			return fmt.Errorf("failed to execute template: %w", err)
		}

		log.Printf("created: %s", filepath)
	}

	return nil
}
