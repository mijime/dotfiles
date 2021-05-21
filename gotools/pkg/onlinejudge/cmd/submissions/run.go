package submissions

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"log"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type Command struct {
	contestID string
}

func New() *Command {
	return &Command{}
}

func (cmd *Command) NewFlagSet() *flag.FlagSet {
	fs := flag.NewFlagSet("submissions", flag.ExitOnError)
	fs.StringVar(&cmd.contestID, "c", "", "contest-id")
	fs.StringVar(&cmd.contestID, "contest", "", "contest-id")

	return fs
}

var errNotSupportedAPI = errors.New("not supoorted api")

type API interface {
	Submissions(context.Context, onlinejudge.SubmissionsInput) ([]onlinejudge.Submission, error)
}

func (cmd *Command) Execute(orgAPI onlinejudge.API) error {
	if api, ok := orgAPI.(API); ok {
		ctx := context.Background()

		subs, err := api.Submissions(ctx, onlinejudge.SubmissionsInput{
			ContestID: cmd.contestID,
		})
		if err != nil {
			return fmt.Errorf("failed to submissions: %w", err)
		}

		for _, sub := range subs {
			log.Println(sub.ProblemID, sub.Status)
		}

		return nil
	}

	return errNotSupportedAPI
}
