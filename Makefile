install: brew_install gotools_install npm_install

update: brew_install gotools_update npm_update

brew_install:
	brew bundle --global --verbose

gotools_install:
	go get -v \
		cuelang.org/go/cmd/cue \
		github.com/cweill/gotests/gotests \
		github.com/golang/protobuf/protoc-gen-go \
		github.com/saibing/bingo \
		github.com/sclevine/yj \
		golang.org/x/lint/golint \
		golang.org/x/tools/cmd/... \
		mvdan.cc/gofumpt/gofumports \
		./gotools/...

gotools_update:
	go mod tidy
	make gotools_install

npm_install:
	npm install

npm_update:
	npm upgrade
	npm prune
