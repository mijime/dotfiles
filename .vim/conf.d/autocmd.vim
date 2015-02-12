autocmd BufWritePre * :%s/\s\+$//ge

function! SOLSpaceHilight()
    syntax match SOLSpace "^\s\+" display containedin=ALL
    highlight SOLSpace term=underline ctermbg=LightGray
endf
function! JISX0208SpaceHilight()
    syntax match JISX0208Space "　" display containedin=ALL
    highlight JISX0208Space term=underline ctermbg=LightCyan
endf
if has("syntax")
    syntax on
    augroup invisible
    autocmd! invisible
"   autocmd BufNew,BufRead * call SOLSpaceHilight()
    autocmd BufNew,BufRead * call JISX0208SpaceHilight()
    augroup END
endif
