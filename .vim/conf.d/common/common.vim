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

imap <C-A> <HOME>
cmap <C-A> <HOME>
nmap <C-A> <HOME>
vmap <C-A> <HOME>
imap <C-B> <LEFT>
cmap <C-B> <LEFT>
nmap <C-B> <LEFT>
vmap <C-B> <LEFT>
imap <C-D> <DEL>
cmap <C-D> <DEL>
nmap <C-D> <DEL>
vmap <C-D> <DEL>
imap <C-E> <END>
cmap <C-E> <END>
nmap <C-E> <END>
vmap <C-E> <END>
imap <C-F> <RIGHT>
cmap <C-F> <RIGHT>
nmap <C-F> <RIGHT>
vmap <C-F> <RIGHT>
imap <C-K> <ESC>
cmap <C-K> <ESC>
nmap <C-K> <ESC>
vmap <C-K> <ESC>
cmap <C-N> <DOWN>
nmap <C-N> <DOWN>
cmap <C-P> <UP>
nmap <C-P> <UP>

nmap j gj
nmap k gk

vmap < <gv
vmap > >gv

if !isdirectory(expand('~/.vim/backup'))
  call system('mkdir -p ~/.vim/backup')
end
set backup
set backupdir=~/.vim/backup

nmap <C-X> [mycommand]
nmap [mycommand]. :<C-U>source %<CR>:<C-U>echo "[reloaded]" expand("%")<CR>
nmap [mycommand]<C-R> :<C-U>!%:h/%<CR>
nmap <ESC><ESC> :<C-U>noh<CR>

setlocal formatoptions-=r
setlocal formatoptions-=o
