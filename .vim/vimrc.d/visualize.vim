Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim', {'on':['Goyo']}
augroup MyJunegunn
  au!
  autocmd VimEnter * nested colo seoul256
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!
augroup END

Plug 'junegunn/limelight.vim', {'on':['Limelight']}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
augroup MyFzfSettings
  autocmd!
  command! -bang -nargs=* GGrep
        \ call fzf#vim#grep(
        \   'git grep --line-number '.shellescape(<q-args>), 0,
        \   { 'dir': systemlist('git rev-parse --show-toplevel')[0] }, <bang>0)
augroup END
Plug 'junegunn/vim-easy-align', {'on':['EasyAlign']}
Plug 'junegunn/gv.vim', {'on':['GV']}

Plug 'tpope/vim-fugitive'

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
