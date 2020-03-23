install: brew_install gotools_install npm_install vim_install pip3_install

update: brew_update gotools_update npm_update vim_update pip3_update

brew_install:
	brew bundle install --global --verbose

brew_update:
	brew update
	make brew_install
	brew bundle cleanup --global --verbose

gotools_install:
	go get -v \
		cuelang.org/go/cmd/cue \
		github.com/cweill/gotests/gotests \
		github.com/golang/protobuf/protoc-gen-go \
		github.com/google/ko/cmd/ko \
		github.com/mijime/twty@master \
		github.com/sachaos/atcoder \
		github.com/saibing/bingo \
		github.com/sclevine/yj \
		github.com/shpota/goxygen \
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

pip3_install:
	pip3 install -r requirements.txt

pip3_update:
	pip3 install --upgrade -r requirements.txt

vim_install:
	vim -c PlugInstall -c quitall

vim_update: vim_install
	vim -c PlugUpdate -c quitall
