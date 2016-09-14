func! JISX0208SpaceHilight()
  syntax match JISX0208Space '　' display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

if has('syntax')
  syntax on
  augroup InvisibleUser
    autocmd!
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    autocmd BufWritePre    * :%s/\s\+$//ge
  augroup END
end