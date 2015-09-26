NeoBundleLazy 'kchmck/vim-coffee-script',{'autoload': {'filetypes': ['coffee']}}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd MyAutoCmd FileType coffee setlocal sw=2 sts=2 ts=2 et

NeoBundleLazy 'vim-scripts/jade.vim',{'autoload': {'filetypes': ['jade']}}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.jade set filetype=jade
autocmd MyAutoCmd FileType jade setlocal sw=2 sts=2 ts=2 et

NeoBundleLazy 'leafgarland/typescript-vim',{'autoload': {'filetypes': ['ts']}}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.ts set filetype=typescript
autocmd MyAutoCmd FileType typescript setlocal sw=2 sts=2 ts=2 et

NeoBundle 'pangloss/vim-javascript'
NeoBundleLazy 'mxw/vim-jsx',{'depends': ['pangloss/vim-javascript']}
