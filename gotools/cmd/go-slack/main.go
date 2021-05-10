package main

import (
	"context"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"

	"github.com/mijime/beareq/pkg/beareq"
	"github.com/mijime/beareq/pkg/client/builder"
)

type slackCommand interface {
	Parse([]string) error
	NewRequest(context.Context) (*http.Request, error)
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

	c := bc.Client()

	req, err := cmd.NewRequest(ctx)
	if err != nil {
		return fmt.Errorf("failed to create request: %w", err)
	}

	resp, err := c.Do(req)
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

func main() {
	cb := builder.NewClientBuilder()

	flag.StringVar(&cb.Profile, "profile", osGetenv("SLACK_BEAREQ_PROFILE", cb.Profile), "")
	flag.Parse()

	args := flag.Args()
	if len(args) == 0 {
		log.Fatal("require sub commands")
	}

	cmd := func(cmd string) slackCommand {
		switch cmd {
		case "channels":
			return &userConversations{}
		case "messages":
			return &conversationsHistory{}
		case "replies":
			return &conversationsReplies{}
		case "post":
			return &chatPostMessage{}
		case "reaction":
			return &reactionsAdd{}
		case "remind":
			return &remindersAdd{}
		case "reminders":
			return &remindersList{}
		case "complete":
			return &remindersComplete{}
		case "status":
			return &usersProfileSet{}
		default:
			return nil
		}
	}(args[0])

	if cmd == nil {
		log.Fatal("not found command")
	}

	if err := cmd.Parse(args[1:]); err != nil {
		log.Fatal(err)
	}

	if err := run(cb, cmd); err != nil {
		log.Fatal(err)
	}
}
