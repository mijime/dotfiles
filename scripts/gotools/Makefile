
install:
	go get -v \
		cuelang.org/go/cmd/cue \
		github.com/cweill/gotests/gotests \
		github.com/golang/protobuf/protoc-gen-go \
		github.com/saibing/bingo \
		github.com/sclevine/yj \
		golang.org/x/lint/golint \
		golang.org/x/tools/cmd/... \
		mvdan.cc/gofumpt/gofumports \
		./...

update:
	go mod tidy
	make install
