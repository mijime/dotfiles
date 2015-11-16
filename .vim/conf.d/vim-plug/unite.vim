Plug 'Shougo/unite.vim', {'on': ['Unite'], 'for': ['unite']}
      \ | Plug 'Shougo/vimfiler',
      \ {'on': ['VimFilerCurrentDir', 'VimFilerBufferDir']}

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
nmap U [unite]

nnoremap [unite]a :<C-u>Unite<CR>
nnoremap [unite]f :<C-u>UniteWithBufferDir file<CR>
nnoremap [unite]b :<C-u>Unite buffer<CR>
nnoremap [unite]r :<C-u>Unite register<CR>
nnoremap [unite]t :<C-u>Unite tab<CR>
nnoremap [unite]m :<C-u>Unite mapping<CR>

autocmd MyAutoCmd FileType unite call <SID>unite_my_settings()

func! <SID>unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)
endf"}}}

nmap [unite]d :<C-u>VimFilerCurrentDir -explorer<CR>
nmap [unite]D :<C-u>VimFilerBufferDir  -explorer<CR>
