Plug 'thinca/vim-quickrun', {'on':['QuickRun']}

Plug 'prettier/vim-prettier', {'do': 'npm install'}

Plug 'dense-analysis/ale'
let g:ale_open_list = 1
let g:ale_keep_list_window_open = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_linters = {'go': ['go vet', 'golint', 'golangci-lint']}

Plug 'prabirshrestha/vim-lsp' |
      \ Plug 'prabirshrestha/async.vim'
Plug 'mattn/vim-lsp-settings' |
      \ Plug 'prabirshrestha/asyncomplete.vim' |
      \ Plug 'prabirshrestha/asyncomplete-lsp.vim'
setlocal omnifunc=lsp#complete
nmap <C-]> :LspDefinition<CR>
nmap K :LspHover<CR>
nmap ]] :LspDocumentSymbol<CR>

Plug 'mattn/vim-goimports'
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal omnifunc=lsp#complete
autocmd BufWritePre *.go LspDocumentFormatSync

Plug 'hashivim/vim-terraform', {'for':['tf']}
let g:terraform_align       = 1
let g:terraform_fmt_on_save = 1

Plug 'sheerun/vim-polyglot'
