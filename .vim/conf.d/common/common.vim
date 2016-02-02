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

" Cache
let $cache = expand('~/.vim/cache/backup')
if !isdirectory($cache) | call mkdir($cache, 'p') | end
set history=1000 viminfo='10,/100,:1000,<10,@10,s10,h,n$cache/.viminfo
set nospell  spellfile=$cache/en.utf-8.add
set swapfile directory=$cache/swap,$cache,/var/tmp/vim,/var/tmp
set nobackup backupdir=$cache/backup,$cache,/var/tmp/vim,/var/tmp
set undofile undolevels=1000 undodir=$cache/undo,$cache,/var/tmp/vim,/var/tmp

" Movement
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-E> <End>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>
inoremap <C-A> <Home>
inoremap <C-B> <Left>
inoremap <C-D> <Del>
inoremap <C-E> <End>
inoremap <C-F> <Right>
nnoremap <C-A> <Home>
nnoremap <C-E> <End>
nnoremap <C-N> <Down>
nnoremap <C-P> <Up>
vnoremap <C-A> <Home>
vnoremap <C-E> <End>
vnoremap <C-N> <Down>
vnoremap <C-P> <Up>

nnoremap j gj
nnoremap k gk
vnoremap < <gv
vnoremap > >gv

nmap <Space> <Leader>
vmap <Space> <Leader>

inoremap <C-L> <C-X><C-O>

augroup vimrc
  autocmd!
  autocmd FileType * setlocal formatoptions-=ro omnifunc=syntaxcomplete#Complete
augroup END
