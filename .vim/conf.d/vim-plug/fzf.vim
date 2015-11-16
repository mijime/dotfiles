Plug 'junegunn/fzf', {
      \ 'on': ['FZF', 'FZFMru', 'FZFBuffer', 'FZFLines'],
      \ 'dir': '~/.fzf',
      \ 'do': './install --all'
      \ }

func! <sid>buffer_list()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endf

func! <sid>buffer_open(e)
  exec 'buffer' matchstr(a:e, '^[ 0-9]*')
endf

func! <sid>mruall_list()
  return extend(
        \ filter(copy(v:oldfiles),
        \ "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
        \ map(filter(range(1, bufnr('$')),
        \ 'buflisted(v:val)'),
        \ 'bufname(v:val)'))
endf

func! <sid>line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endf

func! <sid>buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endf

command! FZFBuffer call fzf#run({
      \ 'source': reverse(<sid>buffer_list()),
      \ 'sink': function('<sid>buffer_open'),
      \ 'options': '+m',
      \ 'down': len(<sid>buffer_list()) + 2
      \ })

command! FZFLines call fzf#run({
      \ 'source': reverse(<sid>buffer_lines()),
      \ 'sink': function('<sid>line_handler'),
      \ 'options': '--extended --nth=3..',
      \ 'down': '60%'
      \ })

command! FZFMru call fzf#run({
      \ 'source': reverse(<sid>mruall_list()),
      \ 'sink': 'e',
      \ 'options': '-m -x +s',
      \ 'down': '40%'
      \ })
