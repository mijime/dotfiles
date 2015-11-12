#!/bin/bash

packages=(
  bash
  binutils
  coreutils
  findutils
  git
  go
  nodebrew
  tmux
  vim
)

brew install ${packages[@]}
