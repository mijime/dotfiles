set bs=2
set enc=utf8
set fileencodings=utf-8,ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set hlsearch
set incsearch
set list
set listchars=tab:>\ ,trail:-,nbsp:%,extends:>,precedes:<
set nocompatible
set number
set expandtab
set autoindent
set smartindent
set cindent
set tabstop=2 shiftwidth=2 softtabstop=0

" netrw
let g:netrw_liststyle = 3
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv = 1
let g:netrw_alto = 1

cmap <C-a> <HOME>
cmap <C-b> <LEFT>
cmap <C-d> <DEL>
cmap <C-e> <END>
cmap <C-f> <RIGHT>
cmap <C-k> <ESC>
cmap <C-n> <DOWN>
cmap <C-p> <UP>

imap <C-a> <HOME>
imap <C-b> <LEFT>
imap <C-d> <DEL>
imap <C-e> <END>
imap <C-f> <RIGHT>
imap <C-k> <ESC>
" imap <C-N> <DOWN>
" imap <C-P> <UP>

nmap <C-a> <HOME>
nmap <C-b> <LEFT>
nmap <C-d> <DEL>
nmap <C-e> <END>
nmap <C-f> <RIGHT>
nmap <C-k> <ESC>
nmap <C-n> <DOWN>
nmap <C-p> <UP>

nmap j gj
nmap k gk

vnoremap < <gv
vnoremap > >gv

if isdirectory($HOME.'/.vim-backup')
    set backup
    set backupdir=~/.vim-backup
endif

nmap <C-c> [mycommand]
nmap [mycommand]. :<C-u>source<Space>%<CR>:<C-u>echo<Space>"[reloaded]"<Space>expand("%")<CR>
nmap [mycommand]<C-r> :<C-u>!%:h/%<CR>

setlocal formatoptions-=r
setlocal formatoptions-=o
