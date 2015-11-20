if has('vim_starting')
  set rtp+=~/.vim/conf.d

  set rtp+=~/.vim/bundle/plugged/vim-plug
  let s:vimplug = expand('~/.vim/bundle/plugged/vim-plug')
  if !isdirectory(s:vimplug)
    echo 'install vim-plug...'
    call mkdir(s:vimplug, 'p')
    call system('git clone https://github.com/junegunn/vim-plug.git', s:vimplug)
  end
  unl s:vimplug
end

let b:plugged = expand('~/.vim/bundle/plugged')
call plug#begin(b:plugged)
  Plug 'junegunn/vim-plug',
        \ {'dir': expand(b:plugged .'/vim-plug/autoload')}
  runt! plugged/*.vim
call plug#end()
unl b:plugged

runt! common/*.vim
