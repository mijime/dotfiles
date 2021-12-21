GOTOOLS = \
					github.com/NYTimes/openapi2proto/cmd/openapi2proto@latest \
					github.com/cweill/gotests/gotests@latest \
					github.com/deepmap/oapi-codegen/cmd/oapi-codegen@latest \
					github.com/golang/mock/mockgen@latest \
					github.com/google/skicka@latest \
					github.com/googleapis/gnostic@latest \
					github.com/jackc/sqlfmt/cmd/sqlfmt@latest \
					github.com/jfeliu007/goplantuml/cmd/goplantuml@latest \
					github.com/k-saiki/mfa@latest \
					github.com/mattn/memo@latest \
					github.com/mijime/beareq/v2/cmd/beareq@latest \
					github.com/shpota/goxygen@latest \
					golang.org/x/tools/cmd/...@latest

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
	cd $(shell git rev-parse --show-toplevel) && \
		for gotool in $(GOTOOLS); do \
		CGO_ENABLED=0 go install -v $$gotool; \
		done
	cd $(shell git rev-parse --show-toplevel)/gotools && \
		CGO_ENABLED=0 go install -v ./...

gotools_update:
	cd $(shell git rev-parse --show-toplevel) && \
		for gotool in $(GOTOOLS); do \
		CGO_ENABLED=0 go install -v $$gotool; \
		done
	cd $(shell git rev-parse --show-toplevel)/gotools && \
		CGO_ENABLED=0 go get -u -v ./... && go mod tidy

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
