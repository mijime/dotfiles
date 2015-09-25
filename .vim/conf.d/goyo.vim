NeoBundle 'junegunn/goyo.vim'
NeoBundle 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

function! s:goyo_enter()
  silent !tmux set status off
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  quit
endfunction

autocmd MyAutoCmd User GoyoEnter nested call <SID>goyo_enter()
autocmd MyAutoCmd User GoyoLeave nested call <SID>goyo_leave()
" autocmd MyAutoCmd BufNewFile,BufRead * call goyo#execute(0,80)
