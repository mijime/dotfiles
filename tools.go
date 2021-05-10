package tools

import (
	_ "cuelang.org/go/cmd/cue"
	_ "github.com/cweill/gotests/gotests"
	_ "github.com/golang/mock/mockgen"
	_ "github.com/golang/protobuf/protoc-gen-go"
	_ "github.com/googleapis/gnostic"
	_ "github.com/jackc/sqlfmt/cmd/sqlfmt"
	_ "github.com/jfeliu007/goplantuml/cmd/goplantuml"
	_ "github.com/k-saiki/mfa"
	_ "github.com/mattn/memo"
	_ "github.com/mijime/beareq/cmd/beareq"
	_ "github.com/shpota/goxygen"
	_ "github.com/sonatype-nexus-community/nancy"
	_ "golang.org/x/lint/golint"
	_ "golang.org/x/tools/gopls"
)
