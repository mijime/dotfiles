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
set laststatus=2
set ruler
set title
set nocursorline
set nocursorcolumn
set ignorecase
set smartcase
set smarttab

" netrw
let g:netrw_liststyle = 3
let g:netrw_list_hide = 'CVS,\(^\|\s\s\)\zs\.\S\+'
let g:netrw_altv = 1
let g:netrw_alto = 1

imap <C-A> <Home>
cmap <C-A> <Home>
nmap <C-A> <Home>
imap <C-E> <End>
cmap <C-E> <End>
nmap <C-E> <End>
imap <C-B> <Left>
cmap <C-B> <Left>
imap <C-F> <Right>
cmap <C-F> <Right>
imap <C-D> <Del>
cmap <C-D> <Del>
imap <C-K> <Esc>
cmap <C-K> <Esc>
nmap <C-K> <Esc>
vmap <C-K> <Esc>
cmap <C-N> <Down>
nmap <C-N> <Down>
cmap <C-P> <Up>
nmap <C-P> <Up>

nmap j gj
nmap k gk

vmap < <gv
vmap > >gv

if !isdirectory(expand('~/.vim/backup'))
  call system('mkdir -p ~/.vim/backup')
end
set backup
set backupdir=~/.vim/backup

setlocal formatoptions-=r
setlocal formatoptions-=o

func! <SID>vimrc_my_settings()"{{{
  nmap <C-X> [vimrc]
  nmap [vimrc]. :<C-U>source %<CR>:<C-U>echo "[reloaded]" expand("%")<CR>
endf"}}}

augroup VimrcUser
  autocmd!
  autocmd FileType vim call <SID>vimrc_my_settings()
augroup END
