Plug 'junegunn/goyo.vim', {'on': 'Goyo'}
Plug 'junegunn/limelight.vim', {'on': 'Limelight'}

func! <SID>goyo_enter()
  Limelight
endf

func! <SID>goyo_leave()
  Limelight!
endf

let g:goyo_width  = '80%'
let g:goyo_height = '80%'

let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

autocmd User GoyoEnter nested call <SID>goyo_enter()
autocmd User GoyoLeave nested call <SID>goyo_leave()

nmap <C-G> [goyo]
nmap [goyo]<C-G> :<C-U>Goyo<CR>
nmap [goyo]<C-L> :<C-U>Limelight!!<CR>
