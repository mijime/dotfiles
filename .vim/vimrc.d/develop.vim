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
      \ 'go': ['govet', 'golint', 'golangci-lint'],
      \ }
let g:ale_fixers = {
      \ 'go':              ['gofmt', 'goimports'],
      \ 'graphql':         ['prettier'],
      \ 'javascript':      ['prettier', 'eslint'],
      \ 'markdown':        ['prettier', 'textlint'],
      \ 'python':          ['black'],
      \ 'sh':              ['shfmt'],
      \ 'sql':             ['sqlformat'],
      \ 'terraform':       ['terraform'],
      \ 'typescript':      ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \ }

let g:ale_sh_shfmt_options      = '-i=2'
let g:ale_sql_sqlformat_options = '--reindent --indent_after_first --indent_columns --keywords upper --identifiers lower'

augroup ALEFixSettings
  autocmd!
  autocmd FileType go              autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype graphql         autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype javascript      autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype markdown        autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype python          autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype sh              autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype sql             autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype terraform       autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype typescript      autocmd BufWritePre <buffer> ALEFix
  autocmd Filetype typescriptreact autocmd BufWritePre <buffer> ALEFix
augroup END

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

" typescript settings
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescriptreact

" sh settings
autocmd Filetype sh setlocal sw=2 sts=2 expandtab
