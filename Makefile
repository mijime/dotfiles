install: brew_install gotools_install npm_install

update: brew_update gotools_update npm_update

brew_install:
	brew bundle --global --verbose

brew_update:
	brew update
	make brew_install
	brew bundle cleanup --global --verbose

gotools_install:
	go get -v \
		cuelang.org/go/cmd/cue \
		github.com/shpota/goxygen \
		github.com/cweill/gotests/gotests \
		github.com/golang/protobuf/protoc-gen-go \
		github.com/mijime/twty@master \
		github.com/sachaos/atcoder \
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
