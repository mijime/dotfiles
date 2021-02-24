Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['csv']

" typescript settings
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" sh settings
autocmd Filetype sh setlocal sw=2 sts=2 expandtab

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
augroup MyFzfSettings
  autocmd!
  command! -bang -nargs=* GGrep
        \ call fzf#vim#grep(
        \   'git grep --line-number '.shellescape(<q-args>), 0,
        \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
augroup END
Plug 'junegunn/vim-easy-align', {'on':['EasyAlign']}
Plug 'junegunn/gv.vim', {'on':['GV']}
