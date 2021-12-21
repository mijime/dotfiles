Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim', {'on':['Goyo']}
augroup MyGoyoSettings
  au!
  function! s:goyo_enter()
    if executable('tmux') && strlen($TMUX)
      silent !tmux set status off
      silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
    endif
    set noshowmode
    set nowrap
    Limelight
  endfunction

  function! s:goyo_leave()
    if executable('tmux') && strlen($TMUX)
      silent !tmux set status on
      silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
    endif
    set showmode
    set wrap
    Limelight!
  endfunction

  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

Plug 'junegunn/limelight.vim', {'on':['Limelight']}
let g:limelight_conceal_ctermfg = 'Gray'
let g:limelight_default_coefficient = 0.2
let g:limelight_paragraph_span = 1

Plug 'itchyny/lightline.vim'
let g:lightline={
      \ 'colorscheme':'seoul256',
      \ 'active': {'left':[['mode','paste'],['readonly','filepath','modified']]},
      \ 'component_function': {
      \ 'filepath': 'FilePathForLightline'
      \ }
      \ }
function! FilePathForLightline()
  let path = expand('%')
  let pathlen = len(path)
  let winlen = winwidth(0)/3
  if pathlen > winlen
    return '...'.path[pathlen-winlen:pathlen]
  endif
  return path
endfunction

Plug 'junegunn/vim-emoji', {'on':['Emojify']}
command -range Emojify <line1>,<line2>s/:\([^:]\+\):/\=emoji#for(submatch(1), submatch(0))/g
augroup MyEmojiSettings
  autocmd!
  autocmd FileType gitcommit setlocal completefunc=emoji#complete
augroup END
