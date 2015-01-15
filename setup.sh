#!/bin/bash

cd ${0%/*}

git submodule init
git submodule update

for bundle_vim in Shougo/neobundle.vim Shougo/vimproc.git tpope/vim-fugitive.git
do
    bundle_path=.vim/bundle/$(echo ${bundle_vim##*/} | sed s%.git$%%g)
    [[ ! -d $bundle_path ]] &&
        git clone git://github.com/$bundle_vim $bundle_path
done

dir=$(pwd)

ln -sf $(echo \
        $dir/.bash* \
        $dir/.dir_colors \
        $dir/.inputrc \
        $dir/.vim* \
        $dir/.gitconfig \
        $dir/.tmux.conf \
        $dir/.gemrc \
        $dir/.bin \
        $dir/.Makefile \
        | sed s%$HOME/%%g) ~

. ~/.bash_profile
