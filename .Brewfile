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
brew 'ripgrep'
brew 'grex'
brew 'coreutils'
brew 'oauth2l'
brew 'emojify'
brew 'grpcurl'
brew 'lab'

tap 'yudai/gotty'
brew 'yudai/gotty/gotty'

tap 'itchyny/tap'
brew 'itchyny/tap/mmv'

if platform == :darwin
  brew 'bash'
  brew 'gawk'
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

brew 'terraformer'
brew 'tfenv'
brew 'tflint'
brew 'tfsec'

tap 'hashicorp/tap'
brew 'hashicorp/tap/terraform-ls'

# cloud/aws

brew 'awscli'
brew 'cfn-format'
brew 'cfn-lint'
brew 'cloudformation-guard'
brew 'rain'

tap 'aws/tap'
brew 'aws/tap/aws-sam-cli'

# cloud/azure

brew 'azure-cli'

# cloud/gcp

cask 'google-cloud-sdk' if platform == :darwin

# lang/go

brew 'go'
brew 'gofumpt'
brew 'goreleaser'
brew 'gopls'
brew 'golangci-lint'

# lang/python

brew 'poetry'
brew 'black'
brew 'pylint'
brew 'pipenv'
brew 'pyenv'

# lang/js

brew 'elm'
brew 'volta'
brew 'deno' if platform == :darwin

# lang/shell

brew 'shellcheck'
brew 'shfmt'

# lang/rust

brew 'rust'
brew 'rustup-init'

# lang/c

brew 'clang-format' if platform == :darwin

# docker

brew 'docker'
brew 'hadolint'
brew 'docker-compose'
brew 'buildkit'
brew 'hyperkit' if platform == :darwin

# containers

brew 'podman'
brew 'lima' if platform == :darwin

# k8s

brew 'minikube'
brew 'kind'
brew 'kubernetes-cli'
brew 'kustomize'
brew 'helm'
brew 'skaffold'
brew 'stern'
brew 'glooctl'

# sql

brew 'sqlparse'

# protobuf

brew 'protobuf'
brew 'protoc-gen-go'
brew 'protoc-gen-go-grpc'

# misc

brew 'gojq'
brew 'gojo'

brew 'gnupg'
brew 'ghq'
brew 'jq'
brew 'yj'
brew 'nkf'
brew 'imagemagick'
brew 'vegeta'
brew 'plantuml'
brew 'youtube-dl'
brew 'hugo'
brew 'ffmpeg'
brew 'unzip' if platform == :darwin
brew 'mkcert'
brew 'translate-shell'
brew 'efm-langserver'
brew 'xsv'
brew 'terminal-notifier' if platform == :darwin

# misc/application

if platform == :darwin
  cask 'firefox'
  cask 'google-chrome'
  cask 'keepassxc'

  cask 'visual-studio-code'
  cask 'rectangle'

  cask 'flutter'
  cask 'android-sdk'
  cask 'cocoapods'
end
