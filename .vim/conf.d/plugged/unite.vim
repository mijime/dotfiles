let b:commandDepends = {'for': ['unite'],
      \ 'on': ['Unite', 'UniteWithBufferDir',
      \ 'VimFilerCurrentDir', 'VimFilerBufferDir']}
Plug 'Shougo/unite.vim', b:commandDepends
      \ | Plug 'Shougo/vimfiler', b:commandDepends
unlet b:commandDepends

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1

func! <SID>unite_my_settings()"{{{
  nmap <buffer> <Esc> <Plug>(unite_exit)
  nmap <buffer> <C-K> <Plug>(unite_exit)
endf"}}}

func! <SID>vimfiler_my_settings()"{{{
  nmap <buffer> <C-K> q
endf"}}}

augroup UniteUser
  autocmd!
  autocmd FileType unite    call <SID>unite_my_settings()
  autocmd FileType vimfiler call <SID>vimfiler_my_settings()
augroup END

nmap <Leader>u [unite]
nmap [unite]  :<C-U>Unite<Space>
nmap [unite]a :<C-U>Unite<CR>
nmap [unite]b :<C-U>Unite buffer<CR>
nmap [unite]r :<C-U>Unite register<CR>
nmap [unite]t :<C-U>Unite tab<CR>
nmap [unite]m :<C-U>Unite mapping<CR>
nmap [unite]d :<C-U>VimFilerCurrentDir -explorer<CR>
nmap [unite]f :<C-U>VimFilerBufferDir  -explorer<CR>
