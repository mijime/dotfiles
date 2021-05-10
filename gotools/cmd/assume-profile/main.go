package main

import (
	"context"
	"flag"
	"fmt"
	"log"
	"os"
	"text/template"
	"time"

	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/credentials/stscreds"
)

const exportBashTmpl = `
export __PREV_AWS_PROFILE="${AWS_PROFILE}";
export AWS_PROFILE="{{ .profile }}";
export AWS_ACCESS_KEY_ID="{{ .cred.AccessKeyID }}";
export AWS_SECRET_ACCESS_KEY="{{ .cred.SecretAccessKey }}";
export AWS_SESSION_TOKEN="{{ .cred.SessionToken }}";
export AWS_SECURITY_TOKEN="{{ .cred.SessionToken }}";
`

const unsetBashTmpl = `
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
		roleArn  string
		duration time.Duration
		unset    bool
	)

	flag.StringVar(&profile, "profile", "", "")
	flag.StringVar(&roleArn, "role-arn", "", "")
	flag.DurationVar(&duration, "duration", time.Hour, "")
	flag.BoolVar(&unset, "unset", false, "")
	flag.Parse()

	if unset {
		fmt.Fprintln(os.Stdout, unsetBashTmpl)

		return
	}

	cfg, err := config.LoadDefaultConfig(
		context.Background(),
		config.WithSharedConfigProfile(profile),
		config.WithAssumeRoleCredentialOptions(
			func(op *stscreds.AssumeRoleOptions) {
				op.Duration = duration
				op.TokenProvider = stdinTokenProvider

				if len(roleArn) > 0 {
					op.RoleARN = roleArn
				}
			},
		),
	)
	if err != nil {
		log.Fatalf("failed to load config: %s", err)
	}

	ctx := context.Background()

	cred, err := cfg.Credentials.Retrieve(ctx)
	if err != nil {
		log.Fatalf("failed to retrieve credentials: %s", err)
	}

	tmpl := template.Must(template.New("exportBashTmpl").Parse(exportBashTmpl))

	err = tmpl.Execute(os.Stdout, map[string]interface{}{
		"profile": profile,
		"cred":    cred,
	})
	if err != nil {
		log.Fatalf("failed to build template: %s", err)
	}
}

func stdinTokenProvider() (string, error) {
	fmt.Fprintf(os.Stderr, "Assume Role MFA token code: ")

	var v string

	_, err := fmt.Fscanln(os.Stdin, &v)
	if err != nil {
		return v, fmt.Errorf("failed to scan mfa token: %w", err)
	}

	return v, nil
}
