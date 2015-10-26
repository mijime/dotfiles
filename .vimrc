" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set nocompatible " Be iMproved
filetype off     " Required!

set runtimepath+=~/.vim/conf.d

if has('vim_starting')
  set nocompatible
  if !isdirectory(expand('~/.vim/bundle/neobundle.vim'))
    echo 'install neobundle...'
    call system('git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
  endif
endif

set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc.vim', {'build': {'unix': 'make'}}

runtime! neobundle/*.vim
call neobundle#end()

filetype plugin indent on " Required!
runtime! common/*.vim
