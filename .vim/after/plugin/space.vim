func! JISX0208SpaceHilight()
  highlight JISX0208Space term=underline ctermbg=LightCyan
  syntax match JISX0208Space '　' display containedin=ALL
endf

func! ExtraWhitespaceHighlight()
  highlight ExtraWhitespace ctermbg=red guibg=red
  syntax match ExtraWhitespace /\s\+$/
endf

if has('syntax')
  syntax on
  augroup InvisibleGroup
    autocmd!
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    autocmd BufNew,BufRead * call ExtraWhitespaceHighlight()
  augroup END
end
