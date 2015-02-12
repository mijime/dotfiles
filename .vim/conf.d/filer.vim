NeoBundleLazy 'Shougo/vimfiler', { 'depends' : [ 'Shougo/unite.vim' ] }

if neobundle#tap('vimfiler')
  nmap <silent> [unite]d :VimFiler -split -simple -winwidth=30 -no-quit<CR>
endif
