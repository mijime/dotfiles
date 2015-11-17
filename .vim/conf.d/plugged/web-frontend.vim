Plug 'kchmck/vim-coffee-script', {'for': ['coffee']}
autocmd BufRead,BufNewFile,BufReadPre *.coffee set filetype=coffee
autocmd FileType coffee setlocal sw=2 sts=2 ts=2 et

Plug 'vim-scripts/jade.vim', {'for': ['jade']}
autocmd BufRead,BufNewFile,BufReadPre *.jade set filetype=jade
autocmd FileType jade setlocal sw=2 sts=2 ts=2 et

Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
autocmd BufRead,BufNewFile,BufReadPre *.ts set filetype=typescript
autocmd FileType typescript setlocal sw=2 sts=2 ts=2 et

Plug 'pangloss/vim-javascript', {'for': ['javascript']}
      \ | Plug 'mxw/vim-jsx',   {'for': ['javascript']}
