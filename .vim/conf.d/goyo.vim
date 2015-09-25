NeoBundle 'junegunn/goyo.vim'
NeoBundle 'junegunn/limelight.vim'

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_guifg = 'DarkGray'

function! s:goyo_enter()
  silent !tmux set status off
  Limelight
endfunction

function! s:goyo_leave()
  silent !tmux set status on
  Limelight!
  quit
endfunction

autocmd MyAutoCmd User GoyoEnter nested call <SID>goyo_enter()
autocmd MyAutoCmd User GoyoLeave nested call <SID>goyo_leave()
autocmd MyAutoCmd BufNew,BufRead * call goyo#execute(0, 80)

NeoBundleLazy 'supermomonga/jazzradio.vim', {'depends': ['Shougo/unite.vim']}
if neobundle#tap('jazzradio.vim')
call neobundle#config({
\   'autoload': {
\     'unite_sources': [
\       'jazzradio'
\     ],
\     'commands': [
\       'JazzradioUpdateChannels',
\       'JazzradioStop',
\       {
\         'name': 'JazzradioPlay',
\         'complete': 'customlist,jazzradio#channel_key_complete'
\       }
\     ],
\     'function_prefix': 'jazzradio'
\   }
\ })
endif
