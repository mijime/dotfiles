Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [['mode', 'paste'], ['fugitive', 'filename']]
      \ }}
