Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes
  nmap <buffer> <f2> <plug>(lsp-rename)
  nmap <buffer> K    <plug>(lsp-hover)
  nmap <buffer> gd   <plug>(lsp-definition)
  inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
endfunction
augroup LspInstall
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
