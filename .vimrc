" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

filetype off
set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))
NeoBundle 'Shougo/neobundle.vim'            " バンドル管理ツール
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
call neobundle#end()
filetype on

set runtimepath+=~/.vim/
runtime! conf.d/*.vim
