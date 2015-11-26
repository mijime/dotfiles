Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}

func! <SID>buffer_list()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endf

func! <SID>buffer_open(e)
  exe 'buffer' matchstr(a:e, '^[ 0-9]*')
endf

func! <SID>mruall_list()
  return extend(filter(copy(v:oldfiles),
        \ "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
        \ map(filter(range(1, bufnr('$')),
        \ 'buflisted(v:val)'), 'bufname(v:val)'))
endf

func! <SID>line_handler(l)
  let keys = split(a:l, ':\t')
  exe 'buf' keys[0]
  exe keys[1]
  normal! ^zz
endf

func! <SID>cmd_handler(l)
  let @" = a:l
endf

func! <SID>buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"),
          \ 'b.":\t".(v:key + 1).":\t".v:val'))
  endfor
  return res
endf

command! FZFBuf call fzf#run({
      \ 'source': <SID>buffer_list(),
      \ 'sink': function('<SID>buffer_open'),
      \ 'options': '+m',
      \ 'down': len(<SID>buffer_list()) + 2
      \ })

command! FZFLine call fzf#run({
      \ 'source': <SID>buffer_lines(),
      \ 'sink': function('<SID>line_handler'),
      \ 'options': '--extended --nth=3..',
      \ 'down': '60%'
      \ })

command! FZFMru call fzf#run({
      \ 'source': <SID>mruall_list(),
      \ 'sink': 'e',
      \ 'options': '-m -x +s',
      \ 'down': '40%'
      \ })

command! -nargs=* -bang -complete=shellcmd FZFCmd call fzf#run({
      \ 'source': printf('%s', <q-args>),
      \ 'sink': function('<SID>cmd_handler'),
      \ 'options': '+m',
      \ 'down': '50%'
      \ })

nnoremap <Leader>f [fzf]
nnoremap [fzf]  :<C-U>FZF<CR>
nnoremap [fzf]b :<C-U>FZFBuf<CR>
nnoremap [fzf]l :<C-U>FZFLine<CR>
nnoremap [fzf]m :<C-U>FZFMru<CR>
nnoremap [fzf]c :<C-U>FZFCmd<Space>
