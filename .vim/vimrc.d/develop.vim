Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['csv']

" typescript settings
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" sh settings
autocmd Filetype sh setlocal sw=2 sts=2 expandtab
