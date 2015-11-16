Plug 'kchmck/vim-coffee-script', {'for': ['coffee']}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd MyAutoCmd FileType coffee setlocal sw=2 sts=2 ts=2 et

Plug 'vim-scripts/jade.vim', {'for': ['jade']}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.jade set filetype=jade
autocmd MyAutoCmd FileType jade setlocal sw=2 sts=2 ts=2 et

Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.ts set filetype=typescript
autocmd MyAutoCmd FileType typescript setlocal sw=2 sts=2 ts=2 et

Plug 'pangloss/vim-javascript', {'for': ['javascript']}
      \ | Plug 'mxw/vim-jsx',   {'for': ['javascript']}
