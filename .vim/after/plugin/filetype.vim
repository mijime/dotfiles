augroup FileTypeUser
  autocmd!
  autocmd FileType coffee setlocal sw=1 sts=2 ts=2 et
  autocmd BufRead,BufNewFile *.coffee set filetype=coffee
  autocmd FileType jade setlocal sw=2 sts=2 ts=2 et
  autocmd BufRead,BufNewFile *.jade set filetype=jade
  autocmd FileType typescript setlocal sw=2 sts=2 ts=2 et
  autocmd BufRead,BufNewFile *.ts,*.tsx set filetype=typescript
  autocmd FileType java setlocal omnifunc=javacomplete#Complete
  autocmd BufRead,BufNewFile *.go set filetype=go
  autocmd FileType go setlocal sw=2 sts=2 ts=2 noexpandtab
  autocmd BufRead,BufNewFile *.ex,*.exs set filetype=elixir
  autocmd FileType elixir setlocal sw=2 sts=2 ts=2 et
  autocmd FileType gitconfig setlocal noexpandtab
  autocmd BufRead,BufNewFile Dockerfile.* set filetype=dockerfile
augroup END
