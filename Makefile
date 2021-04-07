install: brew_install gotools_install npm_install vim_install python_install

update: brew_update gotools_update npm_update vim_update python_update
	git commit -m "chore: update package version" . || true

brew_install:
	brew bundle install --global --verbose

brew_update:
	brew update
	make brew_install
	brew bundle cleanup --global --verbose

gotools_install:
	test -f go.mod || go mod init github.com/mijime/dotfiles
	cd $(shell git rev-parse --show-toplevel) && \
		go get -v \
		cuelang.org/go/cmd/cue \
		github.com/cweill/gotests/gotests \
		github.com/golang/protobuf/protoc-gen-go \
		github.com/googleapis/gnostic/... \
		github.com/jackc/sqlfmt/... \
		github.com/k-saiki/mfa \
		github.com/mattn/memo \
		github.com/mijime/beareq/... \
		github.com/shpota/goxygen \
		golang.org/x/lint/golint \
		golang.org/x/tools/... \
		./gotools/...

gotools_update:
	go mod tidy
	make gotools_install

npm_install:
	npm install

npm_update:
	npm outdated | awk 'NR>1{print$$1"@latest"}' | xargs npm install
	npm prune

python_install:
	poetry install

python_update:
	poetry update

vim_install:
	vim -c PlugInstall -c quitall

vim_update: vim_install
	vim -c PlugUpdate -c quitall
