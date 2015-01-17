#!/bin/bash

cd ${0%/*}

vim_bundles=(
    Shougo/neobundle.vim
    Shougo/vimproc.git
)

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

init_vim_bundle(){
    git submodule init
    git submodule update
    for bundle_vim in ${vim_bundles[@]}
    do
        bundle_path=.vim/bundle/$(echo ${bundle_vim##*/} | sed s%.git$%%g)
        [[ ! -d $bundle_path ]] &&
            git clone git://github.com/$bundle_vim $bundle_path
    done
}

link_dotfiles(){
    dir=$(pwd | sed -e "s%$HOME/%%g")

    ln -sf $(echo ${dotfiles[@]} | sed -e "s%^%$dir/%g" -e "s% % $dir/%g") ~

    . ~/.bash_profile
}

init_vim_bundle
link_dotfiles
