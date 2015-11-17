set nocompatible

if has('vim_starting')
  set rtp+=~/.vim/conf.d

  set rtp+=~/.vim/bundle/plugged/vim-plug
  if !isdirectory(expand('~/.vim/bundle/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/.vim/bundle/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/bundle/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/bundle/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/bundle/plugged/vim-plug/autoload'}
  runtime! plugged/*.vim
call plug#end()

runtime! common/*.vim
