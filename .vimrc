" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

set nocompatible " Be iMproved
filetype off     " Required!

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin($HOME.'/.vim/bundle/')
  NeoBundle 'Shougo/neobundle.vim'
  NeoBundle 'Shougo/unite.vim'
  set runtimepath+=~/.vim/
  runtime! conf.d/*.vim
call neobundle#end()

colorscheme desert " default color
if filereadable($HOME.'/.vimrc.local')
  source ~/.vimrc.local
endif

filetype plugin indent on " Required!
