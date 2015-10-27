" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set nocompatible " Be iMproved
filetype off     " Required!

if has('vim_starting')
  if !isdirectory(expand('~/.vim/bundle/neobundle/neobundle.vim'))
    echo 'install neobundle...'
    call system('mkdir -p ~/.vim/bundle/neobundle')
    call system('git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle/neobundle.vim')
  endif

  if !isdirectory(expand('~/.vim/bundle/vim-plug/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/bundle/vim-plug ~/.vim/autoload')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/bundle/vim-plug/vim-plug')
    call system('ln -sf ~/.vim/bundle/vim-plug/vim-plug/plug.vim ~/.vim/autoload/plug.vim')
  endif
endif

set runtimepath+=~/.vim/conf.d

set runtimepath+=~/.vim/bundle/neobundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/neobundle'))
  let g:neobundle_default_git_protocol='https'
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/vimproc.vim'
  runtime! neobundle/*.vim
call neobundle#end()

call plug#begin('~/.vim/bundle/vim-plug')
  Plug 'junegunn/vim-plug'
  runtime! vim-plug/*.vim
call plug#end()

filetype plugin indent on " Required!
runtime! common/*.vim
