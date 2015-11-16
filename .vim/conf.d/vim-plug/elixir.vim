Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}

autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.ex  set filetype=elixir
autocmd MyAutoCmd BufRead,BufNewFile,BufReadPre *.exs set filetype=elixir
autocmd MyAutoCmd FileType elixir setlocal sw=2 sts=2 ts=2 et
