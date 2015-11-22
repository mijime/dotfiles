if has('lua') && 0
  Plug 'Shougo/neocomplete.vim'
  Plug 'Shougo/context_filetype.vim'

  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 3
end
