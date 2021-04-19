package login

import (
	"context"
	"errors"
	"flag"
	"fmt"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
)

type loginUseUsernameAndPasswordAPI interface {
	LoginUseUsernameAndPassword(ctx context.Context, username, password string) error
}

type Command struct {
	username, password, token string
}

var errNotSupportedAPI = errors.New("not supoorted api")

func (cmd *Command) NewFlagSet() *flag.FlagSet {
	fs := flag.NewFlagSet("login", flag.ExitOnError)
	fs.StringVar(&cmd.username, "u", "", "")
	fs.StringVar(&cmd.username, "username", "", "")
	fs.StringVar(&cmd.password, "p", "", "")
	fs.StringVar(&cmd.password, "password", "", "")
	fs.StringVar(&cmd.token, "t", "", "")
	fs.StringVar(&cmd.token, "token", "", "")

	return fs
}

func (cmd *Command) Execute(orgAPI onlinejudge.API) error {
	if api, ok := orgAPI.(loginUseUsernameAndPasswordAPI); ok {
		ctx := context.Background()
		if err := api.LoginUseUsernameAndPassword(ctx, cmd.username, cmd.password); err != nil {
			return fmt.Errorf("failed to login: %w", err)
		}

		return nil
	}

	return errNotSupportedAPI
}
