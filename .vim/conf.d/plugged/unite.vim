let b:commandDepends = {'for': ['unite'], 'on': [
      \ 'Unite', 'VimFilerCurrentDir', 'VimFilerBufferDir']}
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
  nnoremap <buffer> <C-K> q
endf"}}}

augroup UniteUser
  autocmd!
  autocmd FileType unite    call <SID>unite_my_settings()
  autocmd FileType vimfiler call <SID>vimfiler_my_settings()
augroup END

nnoremap <Leader>u [unite]
nnoremap [unite]  :<C-U>Unite<Space>
nnoremap [unite]a :<C-U>Unite<CR>
nnoremap [unite]b :<C-U>Unite buffer<CR>
nnoremap [unite]r :<C-U>Unite register<CR>
nnoremap [unite]t :<C-U>Unite tab<CR>
nnoremap [unite]m :<C-U>Unite mapping<CR>
nnoremap [unite]d :<C-U>VimFilerCurrentDir -explorer<CR>
nnoremap [unite]f :<C-U>VimFilerBufferDir  -explorer<CR>
nnoremap [unite]u :<C-U>Unite buffer bookmark file<CR>
