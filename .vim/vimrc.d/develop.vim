Plug 'dense-analysis/ale'
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_linters = {
      \ 'go': ['go vet', 'golint', 'golangci-lint']}

Plug 'prettier/vim-prettier', {'do': 'npm install'}
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['csv']

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
let g:asyncomplete_auto_popup = 0
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_popup_delay = 200

Plug 'prabirshrestha/vim-lsp'
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

Plug 'mattn/vim-lsp-settings'

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> K    <plug>(lsp-hover)
  nmap <buffer> gd   <plug>(lsp-definition)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction
augroup LspInstall
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
command! LspDebug let lsp_log_verbose=1 | let lsp_log_file = expand('~/lsp.log')


Plug 'mattn/vim-goimports'

" typescript settings
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact
