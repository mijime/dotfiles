" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set nocompatible " Be iMproved
filetype off     " Required!

if has('vim_starting')
  if !isdirectory(expand('~/.vim/bundle/vim-plug/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/bundle/vim-plug ~/.vim/autoload')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/bundle/vim-plug/vim-plug')
    call system('ln -sf ~/.vim/bundle/vim-plug/vim-plug/plug.vim ~/.vim/autoload/plug.vim')
  endif
endif

set runtimepath+=~/.vim/conf.d

call plug#begin('~/.vim/bundle/vim-plug')
  Plug 'junegunn/vim-plug'
  runtime! vim-plug/*.vim
call plug#end()

filetype plugin indent on " Required!
runtime! common/*.vim
