if &compatible | set nocompatible | end

if has('vim_starting')
  set rtp+=~/.vim/conf.d

  if !isdirectory(expand('~/.vim/bundle/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('git clone https://github.com/junegunn/vim-plug.git ~/.vim/bundle/plugged/vim-plug/autoload')
  end
  set rtp+=~/.vim/bundle/plugged/vim-plug
end

let b:plugged = expand('~/.vim/bundle/plugged')
call plug#begin(b:plugged)
  Plug 'junegunn/vim-plug',
        \ {'dir': expand(b:plugged .'/vim-plug/autoload')}
  Plug 'tpope/vim-unimpaired'
  Plug 'kana/vim-metarw'
  runt! plugged/*.vim
call plug#end()
unl b:plugged

runt! common/*.vim
