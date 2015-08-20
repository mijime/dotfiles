#!/bin/bash

cd ${0%/*}

dotfiles=(
    .bash_profile
    .bashrc
    .bashrc.d
    .bin
    .dir_colors
    .gemrc
    .gitconfig
    .gitignore
    .inputrc
    .Makefile
    .tmux.conf
    .vim
    .vimrc
)

init_gitmodules(){
    git submodule init
    git submodule update
    cd .vim/bundle/vimproc && make
}

link_dotfiles(){
    dir=$(pwd | sed -e "s%$HOME/%%g")
    ln -sf $(echo ${dotfiles[@]} | sed -e "s%^%$dir/%g" -e "s% % $dir/%g") ~
    . ~/.bash_profile
}

link_dotfiles
init_gitmodules
