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
export AWS_ACCESS_KEY_ID="{{ .AccessKeyID }}";
export AWS_SECRET_ACCESS_KEY="{{ .SecretAccessKey }}";
export AWS_SESSION_TOKEN="{{ .SessionToken }}";
export AWS_SECURITY_TOKEN="{{ .SessionToken }}";
`))

func main() {
	var (
		profile  string
		duration time.Duration
	)

	flag.StringVar(&profile, "profile", "", "")
	flag.DurationVar(&duration, "duration", time.Hour, "")
	flag.Parse()

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

	err = bashTmpl.Execute(os.Stdout, cred)
	if err != nil {
		log.Fatalf("failed to output: %s", err)
	}
}

func readTokenCode() (string, error) {
	fmt.Fprintf(os.Stderr, "Enter MFA code: ")

	r := bufio.NewReader(os.Stdin)

	token, err := r.ReadString('\n')
	if err != nil {
		return "", err
	}

	return strings.TrimSpace(token), nil
}
