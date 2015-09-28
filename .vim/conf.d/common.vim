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

cmap <C-A> <HOME>
cmap <C-B> <LEFT>
cmap <C-D> <DEL>
cmap <C-E> <END>
cmap <C-F> <RIGHT>
cmap <C-K> <ESC>
cmap <C-N> <DOWN>
cmap <C-P> <UP>

imap <C-A> <HOME>
imap <C-B> <LEFT>
imap <C-D> <DEL>
imap <C-E> <END>
imap <C-F> <RIGHT>
imap <C-K> <ESC>
" imap <C-N> <DOWN>
" imap <C-P> <UP>

nmap <C-A> <HOME>
nmap <C-B> <LEFT>
nmap <C-D> <DEL>
nmap <C-E> <END>
nmap <C-F> <RIGHT>
nmap <C-K> <ESC>
nmap <C-N> <DOWN>
nmap <C-P> <UP>

nmap j gj
nmap k gk

vnoremap < <gv
vnoremap > >gv

if isdirectory($HOME.'/.vim-backup')
    set backup
    set backupdir=~/.vim-backup
endif

nmap <silent> <Space>. :<C-u>source $MYVIMRC<CR>

setlocal formatoptions-=r
setlocal formatoptions-=o
