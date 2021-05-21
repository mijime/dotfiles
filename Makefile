GOTOOLS = cuelang.org/go/cmd/cue \
					github.com/cweill/gotests/gotests \
					github.com/golang/mock/mockgen \
					github.com/golang/protobuf/protoc-gen-go \
					github.com/googleapis/gnostic \
					github.com/jackc/sqlfmt/cmd/sqlfmt \
					github.com/jfeliu007/goplantuml/cmd/goplantuml \
					github.com/k-saiki/mfa \
					github.com/mattn/memo \
					github.com/mijime/beareq/cmd/beareq \
					github.com/shpota/goxygen \
					github.com/sonatype-nexus-community/nancy \
					golang.org/x/lint/golint \
					golang.org/x/tools/cmd/... \
					golang.org/x/tools/gopls

install: brew_install gotools_install npm_install vim_install python_install

update: brew_update gotools_update npm_update vim_update python_update
	git commit -m "chore: update package version" . || true

brew_install:
	brew bundle install --global

brew_update:
	brew upgrade
	make brew_install
	brew bundle cleanup --global

gotools_install:
	test -f go.mod || go mod init github.com/mijime/dotfiles
	cd $(shell git rev-parse --show-toplevel) && \
		CGO_ENABLED=0 \
		go get -v $(GOTOOLS)
	cd $(shell git rev-parse --show-toplevel)/gotools && \
		CGO_ENABLED=0 \
		go get -v ./...

gotools_update:
	cd $(shell git rev-parse --show-toplevel) && \
		CGO_ENABLED=0 \
		go get -u -v $(GOTOOLS) && go mod tidy
	cd $(shell git rev-parse --show-toplevel)/gotools && \
		CGO_ENABLED=0 \
		go get -u -v ./... && go mod tidy

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
