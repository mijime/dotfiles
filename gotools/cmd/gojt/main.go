package main

import (
	"flag"
	"fmt"
	"log"
	"os"

	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge"
	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge/api/atcoder"
	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge/cmd/download"
	"github.com/mijime/dotfiles/gotools/pkg/onlinejudge/cmd/login"
)

type globalOpt struct {
	provider string
}

func (o *globalOpt) Init(fs *flag.FlagSet) {
	fs.StringVar(&o.provider, "provider", o.provider, "")
}

func (o *globalOpt) DesideUseAPI() (onlinejudge.API, error) {
	switch o.provider {
	case "atcoder":
		cli, err := atcoder.NewClient()
		if err != nil {
			return nil, fmt.Errorf("failed to create client: %w", err)
		}

		return cli, nil
	default:
		return nil, fmt.Errorf("unsupported provider: %s", o.provider)
	}
}

func cmdExec(gopts *globalOpt, cmd onlinejudge.Command, args []string) error {
	fs := cmd.NewFlagSet()

	gopts.Init(fs)

	if err := fs.Parse(args); err != nil {
		return fmt.Errorf("failed to parse flags: %w", err)
	}

	api, err := gopts.DesideUseAPI()
	if err != nil {
		return err
	}

	if err := cmd.Execute(api); err != nil {
		return fmt.Errorf("failed to execute command: %w", err)
	}

	return nil
}

func main() {
	gopts := &globalOpt{
		provider: os.Getenv("GOJT_PROVIDER"),
	}

	gopts.Init(flag.CommandLine)

	flag.Parse()
	args := flag.Args()

	if len(args) == 0 {
		log.Fatal("require sub commands")
	}

	switch args[0] {
	case "submit":
		// TODO Add submit command
	case "login":
		if err := cmdExec(gopts, &login.Command{}, args[1:]); err != nil {
			log.Fatal(err)
		}
	case "d", "download":
		if err := cmdExec(gopts, &download.Command{}, args[1:]); err != nil {
			log.Fatal(err)
		}
	}
}
