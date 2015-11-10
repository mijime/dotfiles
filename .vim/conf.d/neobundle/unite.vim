NeoBundle 'Shougo/unite.vim'

let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
nmap U [unite]

nnoremap <silent> [unite]a :<C-u>Unite<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir<Space>file<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>mapping<CR>

autocmd MyAutoCmd FileType unite call s:unite_my_settings()

func! s:unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-c> <Plug>(unite_exit)
endf"}}}
