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

imap <C-a> <Home>
imap <C-b> <Left>
imap <C-d> <Del>
imap <C-e> <End>
imap <C-f> <Right>
imap <C-k> <Esc>

nmap <C-a> <Home>
nmap <C-b> <Left>
nmap <C-d> <Del>
nmap <C-e> <End>
nmap <C-f> <Right>
nmap <C-k> <Esc>
nmap <C-n> <Down>
nmap <C-p> <Up>

cmap <C-a> <Home>
cmap <C-b> <Left>
cmap <C-d> <Del>
cmap <C-e> <End>
cmap <C-f> <Right>
cmap <C-k> <Esc>
cmap <C-n> <Down>
cmap <C-p> <Up>

nmap j gj
nmap k gk

vnoremap < <gv
vnoremap > >gv

if !isdirectory(expand('~/.vim/backup'))
  call system('mkdir -p ~/.vim/backup')
endif
set backup
set backupdir=~/.vim/backup

nmap <C-x> [mycommand]
nmap [mycommand]. :<C-u>source<Space>%<CR>:<C-u>echo<Space>"[reloaded]"<Space>expand("%")<CR>
nmap [mycommand]<C-r> :<C-u>!%:h/%<CR>

setlocal formatoptions-=r
setlocal formatoptions-=o
