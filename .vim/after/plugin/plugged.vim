let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
      \ 'lang': 'ja',
      \ 'html': {'indentation': '  '}}
let g:go_fmt_autosave      = 0
let g:go_fmt_fail_silently = 1
let g:go_play_open_browser = 0

let g:vim_markdown_folding_disabled = 1

packadd netrw.vim
let g:netrw_alto       = 1
let g:netrw_altv       = 1
let g:netrw_fastbrowse = 2
let g:netrw_keepdir    = 0
let g:netrw_liststyle  = 3
let g:netrw_retmap     = 1
let g:netrw_silent     = 1
let g:netrw_special_syntax = 1

packadd lightline.vim
let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {'left':
      \ [['mode', 'paste'], ['fugitive', 'filename']]}}

packadd neocomplete.vim
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

vmap <Leader>a <Plug>(EasyAlign)

let g:goyo_width  = '85'
let g:goyo_height = '80%'
let g:goyo_linenr = 1
let g:limelight_conceal_ctermfg = 'DarkGray'
let g:limelight_default_coefficient = 0.7
let g:limelight_paragraph_span = 1
let g:limelight_priority = -1
nmap <Leader>g [goyo]
nmap <Leader>gg :<C-U>Goyo<CR>
nmap <Leader>gl :<C-U>Limelight!!<CR>
augroup GoyoUser
  autocmd!
  autocmd User GoyoEnter nested Limelight
        \ | set nowrap
  autocmd User GoyoLeave nested Limelight!
augroup END

packadd vim-metarw
packadd vim-metarw-docker
