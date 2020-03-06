#!/usr/bin/env ruby
# frozen_string_literal: true

tap 'homebrew/core'
tap 'homebrew/bundle'

brew 'bat'
brew 'exa'

brew 'cmake'
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
brew 'make'
brew 'clang-format'
brew 'ipfs'

brew 'git'
brew 'gibo'
brew 'tig'
brew 'hub'
brew 'git-secret'

tap 'github/gh'
brew 'github/gh/gh'

brew 'awscli'
brew 'azure-cli'
brew 'remind101/formulae/assume-role'

brew 'terraformer'
brew 'tfenv'

brew 'circleci'

brew 'go'
brew 'goenv'
brew 'nodebrew'
brew 'elm'
brew 'rustup-init'

brew 'protobuf'
brew 'shellcheck'
brew 'vegeta'
brew 'goreleaser'

brew 'kind'
brew 'kubernetes-cli'
brew 'kustomize'
brew 'helm'
brew 'skaffold'
brew 'stern'
brew 'hadolint'

brew 'w3m'
brew 'mutt'
brew 'imagemagick'
brew 'youtube-dl'
brew 'ffmpeg'

tap 'golangci/tap'
brew 'golangci/tap/golangci-lint'

platform = `uname`.split(/\s+/).first.to_sym.downcase
case platform
when :darwin
  cask_args appdir: "#{ENV['HOME']}/Applications"
  brew 'bash'
  brew 'gawk'

  brew 'coreutils'
  brew 'findutils'

  brew 'pipenv'
  brew 'reattach-to-user-namespace'
  brew 'rmtrash'

  tap 'homebrew/homebrew-cask'

  cask 'docker'
  cask 'firefox'
  cask 'google-chrome'
  cask 'google-cloud-sdk'
  cask 'keepassxc'

when :linux
  brew 'docker-compose'
end
