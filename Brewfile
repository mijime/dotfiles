#!/usr/bin/env ruby
# frozen_string_literal: true

tap 'homebrew/core'
tap 'homebrew/bundle'

brew 'bat'
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

brew 'git'
brew 'gibo'
brew 'tig'
brew 'hub'
brew 'git-secret'

brew 'awscli'
brew 'azure-cli'

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
brew 'golangci/tap/golangci-lint'

brew 'kind'
brew 'kubernetes-cli'
brew 'kustomize'
brew 'helm'
brew 'skaffold'
brew 'stern'

brew 'imagemagick'
brew 'w3m'
brew 'slackcat'
brew 'mutt'

platform = `uname`.split(/\s+/).first.to_sym.downcase
case platform
when :darwin
  cask_args appdir: "#{ENV['HOME']}/Applications"
  tap 'homebrew/homebrew-cask'

  brew 'bash'
  brew 'gawk'

  brew 'coreutils'
  brew 'findutils'
  brew 'vim'

  brew 'pipenv'
  brew 'reattach-to-user-namespace'
  brew 'hadolint'

  cask 'docker'
  cask 'firefox'
  cask 'google-chrome'
  cask 'google-cloud-sdk'
  cask 'keepassxc'
end
