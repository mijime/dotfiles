Plug 'jnwhiteh/vim-golang', {'for': ['go']}
autocmd BufRead,BufNewFile,BufReadPre *.go set filetype=go
autocmd FileType go setlocal sw=2 sts=2 ts=2 noexpandtab

let g:go_fmt_autosave      = 0
let g:go_fmt_fail_silently = 1
let g:go_play_open_browser = 0
