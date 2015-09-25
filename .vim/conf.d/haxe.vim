NeoBundleLazy 'jdonaldson/vaxe'

autocmd MyAutoCmd FileType haxe
      \ setl autowrite
autocmd MyAutoCmd FileType hxml
      \ setl autowrite
autocmd MyAutoCmd FileType nmml.xml
      \ setl autowrite

let g:vaxe_haxe_version = 3

function! s:init_vaxe_keymap()
  nnoremap <buffer> ,vo :<C-u>call vaxe#OpenHxml()<CR>
  nnoremap <buffer> ,vc :<C-u>call vaxe#Ctags()<CR>
  nnoremap <buffer> ,vi :<C-u>call vaxe#ImportClass()<CR>
endfunction

autocmd MyAutoCmd FileType haxe call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType hxml call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType nmml.xml call s:init_vaxe_keymap()

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'

au BufRead,BufNewFile,BufReadPre *.hx set filetype=haxe
autocmd MyAutoCmd FileType haxe setlocal sw=2 sts=2 ts=2 et
