#!/usr/bin/env ruby
# frozen_string_literal: true

platform = `uname`.split(/\s+/).first.to_sym.downcase

tap 'homebrew/core'
tap 'homebrew/bundle'

if platform == :darwin
  cask_args appdir: "#{ENV['HOME']}/Applications"
  tap 'homebrew/homebrew-cask'
end

# terminal

brew 'bat'
brew 'direnv'
brew 'exa'
brew 'fzf'
brew 'pwgen'
brew 'starship'
brew 'tmux'
brew 'tree'
brew 'vim'

if platform == :darwin
  brew 'bash'
  brew 'gawk'
  brew 'rmtrash'
  brew 'reattach-to-user-namespace'
end

# git

brew 'git'
brew 'gibo'
brew 'tig'
brew 'hub'
brew 'git-secret'
tap 'github/gh'
brew 'github/gh/gh'

# cloud/terraform

brew 'terraformer'
brew 'tfenv'

# cloud/aws

brew 'awscli'

# cloud/azure

brew 'azure-cli'

# cloud/gcp

cask 'google-cloud-sdk' if platform == :darwin

# lang/go

brew 'go'
brew 'goreleaser'
tap 'golangci/tap'
brew 'golangci/tap/golangci-lint'

# lang/python

brew 'pyenv'
brew 'pipenv'

# lang/js

brew 'nodebrew'
brew 'elm'

# lang/shell

brew 'shellcheck'

# lang/rust

brew 'rustup-init'

# lang/c

brew 'clang-format'

# docker

cask 'docker' if platform == :darwin
brew 'hadolint'
brew 'docker-compose' if platform == :linux

# k8s

brew 'kind'
brew 'kubernetes-cli'
brew 'kustomize'
brew 'helm'
brew 'skaffold'
brew 'stern'

# misc

brew 'ghq'
brew 'graphviz'
brew 'jq'
brew 'nkf'
brew 'imagemagick'
brew 'protobuf'
brew 'vegeta'
brew 'plantuml'

# misc/application

if platform == :darwin
  cask 'firefox'
  cask 'google-chrome'
  cask 'keepassxc'
end
