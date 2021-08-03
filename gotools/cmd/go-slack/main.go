package main

import (
	"bufio"
	"context"
	_ "embed"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"sort"

	"github.com/mijime/beareq/v2/pkg/beareq"
	"github.com/mijime/beareq/v2/pkg/client/builder"
	"github.com/mijime/beareq/v2/pkg/openapi"
	"github.com/mijime/beareq/v2/pkg/suggest"
)

type slackCommand interface {
	Parse(args []string) error
	NewRequest(ctx context.Context) (*http.Request, error)
	HandleResponse(ctx context.Context, resp *http.Response) error
}

func run(cb beareq.ClientBuilder, cmd slackCommand) error {
	ctx := context.Background()

	bc, err := cb.BuildClient(ctx)
	if err != nil {
		return fmt.Errorf("failed to build client: %w", err)
	}

	if closer, ok := bc.(io.Closer); ok {
		defer closer.Close()
	}

	req, err := cmd.NewRequest(ctx)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}

	resp, err := bc.Do(req)
	if err != nil {
		return fmt.Errorf("failed to do request: %w", err)
	}

	defer resp.Body.Close()

	if err := cmd.HandleResponse(ctx, resp); err != nil {
		return fmt.Errorf("failed to handle request: %w", err)
	}

	return nil
}

func osGetenv(key, defVal string) string {
	val := os.Getenv(key)
	if len(val) > 0 {
		return val
	}

	return defVal
}

//go:generate curl -L https://raw.githubusercontent.com/slackapi/slack-api-specs/master/web-api/slack_web_openapi_v2_without_examples.json -o specs/slack.json
//go:embed specs/slack.json
var openAPISpec []byte

type slackOpereationCommand struct {
	*openapi.Operation
}

func (c *slackOpereationCommand) Parse(args []string) error {
	return c.Operation.FlagSet("SLACK_BEAREQ").Parse(args)
}

func (c *slackOpereationCommand) NewRequest(ctx context.Context) (*http.Request, error) {
	return c.BuildRequest(ctx, c.BaseURL+c.Path)
}

func (c *slackOpereationCommand) HandleResponse(ctx context.Context, resp *http.Response) error {
	out := bufio.NewWriter(os.Stdout)
	defer out.Flush()

	if _, err := io.Copy(out, resp.Body); err != nil {
		return fmt.Errorf("failed to write output: %w", err)
	}

	defer resp.Body.Close()

	return nil
}

func main() {
	cmds := make(map[string]slackCommand)
	cmds["channels"] = &userConversations{}
	cmds["messages"] = &conversationsHistory{}
	cmds["replies"] = &conversationsReplies{}
	cmds["post"] = &chatPostMessage{}
	cmds["reaction"] = &reactionsAdd{}
	cmds["remind"] = &remindersAdd{}
	cmds["reminders"] = &remindersList{}
	cmds["complete"] = &remindersComplete{}
	cmds["status"] = &usersProfileSet{}

	ops, err := openapi.GenerateOperationFromData("https://api.slack.com/api", openAPISpec)
	if err == nil {
		for name, op := range ops {
			cmds[name] = &slackOpereationCommand{Operation: op}
		}
	}

	cb := builder.NewClientBuilder()

	flag.StringVar(&cb.Profile, "profile", osGetenv("SLACK_BEAREQ_PROFILE", cb.Profile), "")
	flag.BoolVar(&cb.RefreshToken, "refresh-token", false, "")
	flag.Parse()

	args := flag.Args()

	if len(args) == 0 {
		fmt.Fprint(os.Stderr, "supported subcommands:\n")

		cmdNames := make([]string, 0, len(cmds))

		for cmdName := range cmds {
			cmdNames = append(cmdNames, cmdName)
		}

		sort.Strings(cmdNames)

		for _, cmdName := range cmdNames {
			fmt.Fprintf(os.Stderr, "\t- %s\n", cmdName)
		}

		os.Exit(1)
	}

	cmd, ok := cmds[args[0]]
	if !ok {
		fmt.Fprintf(os.Stderr, "unsupported subcommand %s: the more similar command is\n", args[0])
		cmdNames := make([]string, 0, len(cmds))

		for cmdName := range cmds {
			cmdNames = append(cmdNames, cmdName)
		}

		for _, cmdName := range suggest.Suggest(cmdNames, args[0], 5) {
			fmt.Fprintf(os.Stderr, "\t- %s\n", cmdName)
		}

		os.Exit(1)
	}

	if err := cmd.Parse(args[1:]); err != nil {
		log.Fatal(err)
	}

	if err := run(cb, cmd); err != nil {
		log.Fatal(err)
	}
}
