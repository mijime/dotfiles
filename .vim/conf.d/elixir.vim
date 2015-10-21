NeoBundle 'elixir-lang/vim-elixir'
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.ex set filetype=elixir
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.exs set filetype=elixir
autocmd MyAutoCmd FileType ex setlocal sw=2 sts=2 ts=2 et
