Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}

func! <sid>goyo_enter()
  Limelight
endf

func! <sid>goyo_leave()
  Limelight!
endf

let g:goyo_width  = '80%'
let g:goyo_height = '80%'

let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

autocmd MyAutoCmd User GoyoEnter nested call <sid>goyo_enter()
autocmd MyAutoCmd User GoyoLeave nested call <sid>goyo_leave()

nmap [goyo]<C-G> :<C-U>Goyo<CR>
nmap [goyo]<C-L> :<C-U>Limelight!!<CR>
nmap <C-G> [goyo]
