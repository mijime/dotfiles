Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['csv']

" typescript settings
Plug 'leafgarland/typescript-vim', {'for':['typescript','typescriptreact']}
Plug 'peitalin/vim-jsx-typescript', {'for':['typescript','typescriptreact']}
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

"go testtings
Plug 'buoto/gotests-vim', {'on': ['GoTests', 'GoTestsAll'], 'for': ['go']}

" sh settings
autocmd Filetype sh setlocal sw=2 sts=2 expandtab

Plug 'ruanyl/vim-gh-line'
Plug 'tpope/vim-fugitive' | Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'

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

Plug 'mattn/vim-sonictemplate', {'on':['Template']}

Plug 'tpope/vim-fireplace', {'for': 'clojure'}
