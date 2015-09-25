NeoBundle 'kchmck/vim-coffee-script'
au BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd MyAutoCmd FileType coffee setlocal sw=2 sts=2 ts=2 et

NeoBundle 'vim-scripts/jade.vim'
au BufRead,BufNewFile,BufReadPre *.jade set filetype=jade
autocmd MyAutoCmd FileType jade setlocal sw=2 sts=2 ts=2 et

NeoBundle 'leafgarland/typescript-vim'
au BufRead,BufNewFile,BufReadPre *.ts set filetype=typescript
autocmd MyAutoCmd FileType typescript setlocal sw=2 sts=2 ts=2 et
