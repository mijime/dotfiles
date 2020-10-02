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
brew 'w3m'
brew 'yj'
brew 'wget'
brew 'cmake'
brew 'make'
brew 'rsync'

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
brew 'gh'

# cloud/terraform

brew 'tfenv'
brew 'terraformer'

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

brew 'poetry'
brew 'black'
brew 'pylint'
brew 'pipenv'
brew 'pyenv'

# lang/js

brew 'elm'
brew 'node'

# lang/shell

brew 'shellcheck'

# lang/rust

brew 'rust'
brew 'rustup-init'

# lang/c

brew 'clang-format'

# docker

cask 'docker' if platform == :darwin
brew 'hadolint'
brew 'docker-compose' if platform == :linux

# k8s

brew 'kind'
brew 'kubernetes-cli' if platform == :linux
brew 'kustomize'
brew 'helm'
brew 'skaffold'
brew 'stern'

# misc

brew 'ghq'
brew 'jq'
brew 'nkf'
brew 'imagemagick'
brew 'protobuf'
brew 'vegeta'
brew 'plantuml'
brew 'youtube-dl'
brew 'hugo'
brew 'ffmpeg'
brew 'yj'
brew 'unzip' if platform == :darwin

# misc/application

if platform == :darwin
  cask 'firefox'
  cask 'google-chrome'
  cask 'keepassxc'
end
