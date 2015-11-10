NeoBundleLazy 'Shougo/vimfiler',{'depends':['Shougo/unite.vim']}
if neobundle#tap('vimfiler')
  nmap [unite]d :VimFilerCurrentDir -explorer<CR>
  nmap [unite]D :VimFilerBufferDir  -explorer<CR>
endif
