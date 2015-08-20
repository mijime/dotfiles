colorscheme desert

set bs=2
set enc=utf8
set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932
set hlsearch
set incsearch
set list
set listchars=tab:>\ ,trail:-,nbsp:%,extends:>,precedes:<
set nocompatible
set number
set expandtab
" set autoindent
" set smartindent
" set cindent
set tabstop=2 shiftwidth=2 softtabstop=0

" netrw
let g:netrw_liststyle = 3
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv = 1
let g:netrw_alto = 1

cmap <C-B> <LEFT>
cmap <C-F> <RIGHT>
cmap <C-P> <UP>
cmap <C-N> <DOWN>

imap <C-B> <LEFT>
imap <C-F> <RIGHT>
imap <C-D> <DEL>
imap <C-K> <ESC>

nmap <C-B> <LEFT>
nmap <C-F> <RIGHT>
nmap <C-A> <HOME>
nmap <C-E> <END>
nmap j gj
nmap k gk

vnoremap < <gv
vnoremap > >gv

if isdirectory("$HOME/.vim-backup")
    set backup
    set backupdir=$HOME/.vim-backup
endif

nmap <silent> <Space>. :<C-u>tabedit $MYVIMRC<CR>

setlocal formatoptions-=r
setlocal formatoptions-=o
