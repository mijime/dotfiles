" release autogroup in MyAutoCmd
augroup MyAutoCmd
    autocmd!
augroup END

filetype off

set runtimepath+=$HOME/.vim/bundle/neobundle.vim/
call neobundle#begin(expand($HOME.'/.vim/bundle/'))

NeoBundle 'Align'                           " テキストファイルを整形する
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'Shougo/neobundle.vim'            " バンドル管理ツール
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'ZenCoding.vim'                   " HTML入力効率化
NeoBundle 'fatih/vim-go'
NeoBundle 'jdonaldson/vaxe'
NeoBundle 'taku-o/vim-toggle'               " +でtrue <-> falseなどをtoggle
NeoBundle 'tpope/vim-fugitive'              " ブランチを表示
NeoBundle 'VimClojure'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-scripts/jade.vim'

call neobundle#end()
