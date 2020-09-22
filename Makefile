install: brew_install gotools_install npm_install vim_install python_install

update: brew_update gotools_update npm_update vim_update python_update

brew_install:
	brew bundle install --global --verbose

brew_update:
	brew update
	make brew_install
	brew bundle cleanup --global --verbose

gotools_install:
	[[ -f go.mod ]] || go mod init github.com/mijime/dotfiles
	go get -v \
		cuelang.org/go/cmd/cue \
		github.com/cweill/gotests/gotests \
		github.com/golang/protobuf/protoc-gen-go \
		github.com/google/ko/cmd/ko \
		github.com/k-saiki/mfa \
		github.com/mattn/memo \
		github.com/sachaos/ac-deck \
		github.com/shpota/goxygen \
		golang.org/x/lint/golint \
		golang.org/x/tools/gopls/... \
		golang.org/x/tools/... \
		mvdan.cc/gofumpt/gofumports \
		./gotools/...

gotools_update:
	go mod tidy
	make gotools_install

npm_install:
	npm install

npm_update:
	npm outdated | awk 'NR>1{print$$1}' | xargs npm update
	npm prune

python_install:
	poetry install

python_update:
	poetry update

vim_install:
	vim -c PlugInstall -c quitall

vim_update: vim_install
	vim -c PlugUpdate -c quitall
