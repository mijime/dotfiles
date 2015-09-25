NeoBundleLazy 'jdonaldson/vaxe',{'autoload': {'filetypes': ['hx']}}

autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.hx set filetype=haxe
autocmd MyAutoCmd FileType haxe call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType haxe setlocal autowrite
autocmd MyAutoCmd FileType haxe setlocal sw=2 sts=2 ts=2 et
autocmd MyAutoCmd FileType hxml call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType hxml setlocal autowrite
autocmd MyAutoCmd FileType nmml.xml call s:init_vaxe_keymap()
autocmd MyAutoCmd FileType nmml.xml setlocal autowrite

let g:vaxe_haxe_version = 3
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.haxe = '\v([\]''"\)]|\w|(^\s*))(\.|\()'

function! s:init_vaxe_keymap()
  nnoremap <buffer> ,vo :<C-u>call vaxe#OpenHxml()<CR>
  nnoremap <buffer> ,vc :<C-u>call vaxe#Ctags()<CR>
  nnoremap <buffer> ,vi :<C-u>call vaxe#ImportClass()<CR>
endfunction
