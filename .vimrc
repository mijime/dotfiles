" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

set nocompatible " Be iMproved
filetype off     " Required!

set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
set runtimepath+=~/.vim/
runtime! conf.d/*.vim
call neobundle#end()

filetype plugin indent on " Required!
