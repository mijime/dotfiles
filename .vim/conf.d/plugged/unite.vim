let b:dependsVimfiler = ['VimFilerCurrentDir', 'VimFilerBufferDir']
let b:dependsUnite    = b:dependsVimfiler + ['Unite']

Plug 'Shougo/vimfiler',  {'on': b:dependsVimfiler}
Plug 'Shougo/unite.vim', {'on': b:dependsUnite, 'for': ['unite']}

unlet b:dependsUnite b:dependsVimfiler

let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
nmap U [unite]

nmap [unite]a :<C-u>Unite<CR>
nmap [unite]f :<C-u>UniteWithBufferDir file<CR>
nmap [unite]b :<C-u>Unite buffer<CR>
nmap [unite]r :<C-u>Unite register<CR>
nmap [unite]t :<C-u>Unite tab<CR>
nmap [unite]m :<C-u>Unite mapping<CR>

autocmd FileType unite call <SID>unite_my_settings()

func! <SID>unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
  nmap <buffer> <C-k> <Plug>(unite_exit)
endf"}}}

nmap [unite]d :<C-u>VimFilerCurrentDir -explorer<CR>
nmap [unite]D :<C-u>VimFilerBufferDir  -explorer<CR>
