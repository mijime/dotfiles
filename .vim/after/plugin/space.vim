func! JISX0208SpaceHilight()
  syntax match JISX0208Space '　' display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

if has('syntax')
  syntax on
  augroup InvisibleGroup
    autocmd!
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    autocmd BufWritePre    * :%s/\s\+$//ge
    command RemoveInvisibleGroup augroup InvisibleGroup | autocmd! | augroup END
  augroup END
end
