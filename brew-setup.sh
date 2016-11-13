#!/bin/bash

if ! type brew
then curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install \
  | ruby
fi
brew update
brew upgrade
brew cleanup

while read package
do brew install ${package[@]}
done <<EOF
bash
binutils
coreutils
findutils
git
go
nodebrew
tmux
vim
EOF
