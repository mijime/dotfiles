Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}

autocmd BufRead,BufNewFile,BufReadPre *.ex  set filetype=elixir
autocmd BufRead,BufNewFile,BufReadPre *.exs set filetype=elixir
autocmd FileType elixir setlocal sw=2 sts=2 ts=2 et
