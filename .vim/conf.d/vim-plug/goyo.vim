Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

func! s:goyo_enter()
  Limelight
  nmap [goyo]<C-g> :<C-u>Goyo!<CR>
endf

func! s:goyo_leave()
  Limelight!
  nmap [goyo]<C-g> :<C-u>Goyo<CR>
endf

let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

autocmd MyAutoCmd User GoyoEnter nested call s:goyo_enter()
autocmd MyAutoCmd User GoyoLeave nested call s:goyo_leave()

nmap [goyo]<C-g> :<C-u>Goyo<CR>
nmap <C-g> [goyo]
