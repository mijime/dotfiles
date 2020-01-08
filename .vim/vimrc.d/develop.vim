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
let g:ale_linters = {'go': [
      \ 'gofmt', 'goimports', 'go vet', 'golint', 'golangci-lint'
      \ ]}

Plug 'haya14busa/vim-auto-programming'
set completefunc=autoprogramming#complete

Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/async.vim' |
      \ Plug 'prabirshrestha/asyncomplete.vim' |
      \ Plug 'prabirshrestha/asyncomplete-lsp.vim' |
      \ Plug 'mattn/vim-lsp-settings'
setlocal omnifunc=lsp#complete
nmap <C-]> :LspDefinition<CR>
nmap K :LspHover<CR>
nmap ]] :LspDocumentSymbol<CR>

Plug 'rhysd/vim-goyacc', {'for':['goyacc']}
autocmd FileType goyacc setlocal noexpandtab

Plug 'mattn/vim-goimports'
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal omnifunc=lsp#complete
autocmd BufWritePre *.go LspDocumentFormatSync

Plug 'digitaltoad/vim-pug', {'for':['pug']}
augroup MyPug
  au!
  autocmd BufRead,BufNewFile *.pug set filetype=pug
augroup END

Plug 'leafgarland/typescript-vim', {'for':['typescript']}
autocmd BufRead,BufNewFile *.tsx set filetype=typescript

Plug 'ElmCast/elm-vim', {'for': 'elm'}
let g:elm_setup_keybindings = 0

Plug 'OmniSharp/omnisharp-vim', {'for':['cs']}
let g:OmniSharp_selector_ui = 'fzf'

Plug 'baabelfish/nvim-nim', {'for':['nim']}
Plug 'cespare/vim-toml', {'for':['toml']}
Plug 'hashivim/vim-terraform', {'for':['tf']}
let g:terraform_align       = 1
let g:terraform_fmt_on_save = 1


Plug 'udalov/kotlin-vim', {'for':['kotlin']}
augroup MyKotlin
  au!
  autocmd BufRead,BufNewFile *.kt set filetype=kotlin
augroup END
