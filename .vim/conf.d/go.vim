NeoBundleLazy 'jnwhiteh/vim-golang',{'autoload': {'filetypes': ['go']}}
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.go set filetype=go
autocmd MyAutoCmd FileType go setlocal sw=2 sts=2 ts=2 et

let g:go_fmt_autosave = 0
let g:go_play_open_browser = 0
let g:go_fmt_fail_silently = 1
