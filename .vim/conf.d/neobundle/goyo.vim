NeoBundle 'junegunn/goyo.vim'
NeoBundle 'junegunn/limelight.vim'

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  set number
  Limelight
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  quit
endfunction

let g:limelight_conceal_ctermfg = 'darkgray'
let g:limelight_conceal_guifg = 'darkgray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1

autocmd MyAutoCmd User GoyoEnter nested call <SID>goyo_enter()
autocmd MyAutoCmd User GoyoLeave nested call <SID>goyo_leave()
" autocmd MyAutoCmd BufNewFile,BufRead * call goyo#execute(0,80)
