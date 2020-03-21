func! JISX0208SpaceHilight()
  syntax match JISX0208Space '　' display containedin=ALL
  highlight JISX0208Space term=underline ctermbg=LightCyan
endf

func! ExtraWhitespaceHighlight()
  match ExtraWhitespace /\s\+$/
  highlight ExtraWhitespace ctermbg=red guibg=red
endf

if has('syntax')
  syntax on
  augroup InvisibleGroup
    autocmd!
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    autocmd BufNew,BufRead * call ExtraWhitespaceHighlight()
    autocmd BufWritePre    * :%s/\s\+$//ge
  augroup END
end
