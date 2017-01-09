#!/bin/bash

set -ue

if ! type brew
then curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install \
  | ruby
fi

brew update
brew upgrade

while read package
do brew install ${package[@]}
done <<EOF
autoconf
automake
awscli
bash
binutils
coreutils
findutils
docker
docker-compose
docker-machine
ffmpeg
git
go
lua
nkf
node
reattach-to-user-namespace
ruby
swift
tmux
vim --with-lua
yarn
youtube-dl
EOF

brew cleanup
