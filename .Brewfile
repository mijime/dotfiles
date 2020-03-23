#!/usr/bin/env ruby
# frozen_string_literal: true

platform = `uname`.split(/\s+/).first.to_sym.downcase

tap 'homebrew/core'
tap 'homebrew/bundle'

brew 'bat'
brew 'exa'

brew 'direnv'
brew 'fzf'
brew 'ghq'
brew 'graphviz'
brew 'jq'
brew 'nkf'
brew 'pwgen'
brew 'starship'
brew 'tmux'
brew 'tree'
brew 'vim'

brew 'git'
brew 'gibo'
brew 'tig'
brew 'hub'
brew 'git-secret'

tap 'github/gh'
brew 'github/gh/gh'

brew 'awscli'
brew 'azure-cli'

brew 'terraformer'
brew 'tfenv'

brew 'go'
brew 'pyenv'
brew 'pipenv'
brew 'nodebrew'
brew 'elm'
brew 'rustup-init'

brew 'clang-format'
brew 'shellcheck'
brew 'goreleaser'
brew 'kind'
brew 'kubernetes-cli'
brew 'kustomize'
brew 'helm'
brew 'skaffold'
brew 'stern'
brew 'hadolint'

brew 'imagemagick'
brew 'protobuf'
brew 'vegeta'
brew 'plantuml'

tap 'golangci/tap'
brew 'golangci/tap/golangci-lint'

brew 'docker-compose' if platform == :linux

if platform == :darwin
  cask_args appdir: "#{ENV['HOME']}/Applications"
  brew 'bash'
  brew 'gawk'

  brew 'rmtrash'
  brew 'reattach-to-user-namespace'

  tap 'homebrew/homebrew-cask'

  cask 'docker'
  cask 'firefox'
  cask 'google-chrome'
  cask 'google-cloud-sdk'
  cask 'keepassxc'

end
