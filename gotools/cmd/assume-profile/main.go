package main

import (
	"bufio"
	"flag"
	"fmt"
	"log"
	"os"
	"strings"
	"text/template"
	"time"

	"github.com/aws/aws-sdk-go/aws/credentials/stscreds"
	"github.com/aws/aws-sdk-go/aws/session"
)

var bashTmpl = template.Must(template.New("bashTmpl").Parse(`
export __PREV_AWS_PROFILE="${AWS_PROFILE}";
export AWS_PROFILE="{{ .profile }}";
export AWS_ACCESS_KEY_ID="{{ .cred.AccessKeyID }}";
export AWS_SECRET_ACCESS_KEY="{{ .cred.SecretAccessKey }}";
export AWS_SESSION_TOKEN="{{ .cred.SessionToken }}";
export AWS_SECURITY_TOKEN="{{ .cred.SessionToken }}";
`))

var unsetBashTmpl = `
export AWS_PROFILE="${__PREV_AWS_PROFILE}";
unset __PREV_AWS_PROFILE;
unset AWS_ACCESS_KEY_ID;
unset AWS_SECRET_ACCESS_KEY;
unset AWS_SESSION_TOKEN;
unset AWS_SECURITY_TOKEN;
`

func main() {
	var (
		profile  string
		duration time.Duration
		unset    bool
	)

	flag.StringVar(&profile, "profile", "", "")
	flag.DurationVar(&duration, "duration", time.Hour, "")
	flag.BoolVar(&unset, "unset", false, "")
	flag.Parse()

	if unset {
		fmt.Fprintln(os.Stdout, unsetBashTmpl)

		return
	}

	stscreds.DefaultDuration = duration

	sess := session.Must(session.NewSessionWithOptions(session.Options{
		Profile:                 profile,
		SharedConfigState:       session.SharedConfigEnable,
		AssumeRoleTokenProvider: readTokenCode,
	}))

	cred, err := sess.Config.Credentials.Get()
	if err != nil {
		log.Fatalf("failed to get credentials: %s", err)
	}

	err = bashTmpl.Execute(os.Stdout, map[string]interface{}{
		"profile": profile,
		"cred":    cred,
	})
	if err != nil {
		log.Fatalf("failed to output: %s", err)
	}
}

func readTokenCode() (string, error) {
	fmt.Fprintf(os.Stderr, "Enter MFA code: ")

	r := bufio.NewReader(os.Stdin)

	token, err := r.ReadString('\n')
	if err != nil {
		return "", fmt.Errorf("failed to read token: %w", err)
	}

	return strings.TrimSpace(token), nil
}
