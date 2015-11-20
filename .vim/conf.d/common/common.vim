if &compatible | set nocompatible | end

set bs=2
set list listchars=tab:>\ ,trail:-,nbsp:%,extends:>,precedes:<
set autoindent smartindent cindent
set tabstop=2 shiftwidth=2 softtabstop=0 expandtab smarttab
set number ruler title laststatus=2
set nocursorline nocursorcolumn

" Encoding
if &encoding !=? 'utf-8' | let &termencoding = &encoding | end
set encoding=utf-8 fileencoding=utf-8 fileformats=unix,mac,dos
set fileencodings=utf-8,iso-2022-jp-3,euc-jisx0213,cp932,euc-jp,sjis,jis,latin,iso-2022-jp

" Clipboard
set clipboard=unnamed,unnamedplus

" Performance
set updatetime=300 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast nolazyredraw

" Search
set wrapscan ignorecase smartcase incsearch hlsearch magic

" cache files
let $cache = expand('~/.vim/cache')
if !isdirectory($cache) | call mkdir($cache, 'p') | end
set history=1000 viminfo='10,/100,:1000,<10,@10,s10,h,n$cache/.viminfo
set nospell  spellfile=$cache/en.utf-8.add
set swapfile directory=$cache/swap,$cache,/var/tmp/vim,/var/tmp
set nobackup backupdir=$cache/backup,$cache,/var/tmp/vim,/var/tmp
set undofile undolevels=1000 undodir=$cache/undo,$cache,/var/tmp/vim,/var/tmp

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

func! <SID>vimrc_my_settings()"{{{
  nmap <C-X> [vimrc]
  nmap [vimrc]. :<C-U>source %<CR>:<C-U>echo "[reloaded]" expand("%")<CR>
endf"}}}

augroup vimrc
  autocmd!
  autocmd FileType vim call <SID>vimrc_my_settings()
  autocmd FileType *   setlocal formatoptions-=ro
augroup END
