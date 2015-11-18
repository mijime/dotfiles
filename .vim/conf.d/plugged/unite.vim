let b:commandDepends = ['Unite', 'UniteWithBufferDir',
      \ 'VimFilerCurrentDir', 'VimFilerBufferDir']
Plug 'Shougo/unite.vim', {'on': b:commandDepends, 'for': ['unite']}
      \ | Plug 'Shougo/vimfiler', {'on': b:commandDepends}
unlet b:commandDepends

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
nmap <S-U> [unite]

nmap [unite]  :<C-U>Unite<Space>
nmap [unite]a :<C-U>Unite<CR>
nmap [unite]f :<C-U>UniteWithBufferDir file<CR>
nmap [unite]b :<C-U>Unite buffer<CR>
nmap [unite]r :<C-U>Unite register<CR>
nmap [unite]t :<C-U>Unite tab<CR>
nmap [unite]m :<C-U>Unite mapping<CR>

func! <SID>unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-K> <Plug>(unite_exit)
endf"}}}

nmap [unite]d     :<C-U>VimFilerCurrentDir -explorer<CR>
nmap [unite]<S-D> :<C-U>VimFilerBufferDir  -explorer<CR>

func! <SID>vimfiler_my_settings()"{{{
  nmap <buffer> <C-K> q
endf"}}}

augroup UniteUser
  autocmd!
  autocmd FileType unite    call <SID>unite_my_settings()
  autocmd FileType vimfiler call <SID>vimfiler_my_settings()
augroup END
