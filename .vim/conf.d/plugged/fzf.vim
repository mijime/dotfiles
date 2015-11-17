Plug 'junegunn/fzf', {'on': ['FZF'],
      \ 'dir': '~/.fzf', 'do': './install --all'}

func! <SID>buffer_list()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endf

func! <SID>buffer_open(e)
  exec 'buffer' matchstr(a:e, '^[ 0-9]*')
endf

func! <SID>mruall_list()
  return extend(filter(copy(v:oldfiles),
        \ "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
        \ map(filter(range(1, bufnr('$')),
        \ 'buflisted(v:val)'), 'bufname(v:val)'))
endf

func! <SID>line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endf

func! <SID>buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"),
          \ 'b.":\t".(v:key + 1).":\t".v:val'))
  endfor
  return res
endf

command! FZFBuffer call fzf#run({
      \ 'source': reverse(<SID>buffer_list()),
      \ 'sink': function('<SID>buffer_open'),
      \ 'options': '+m',
      \ 'down': len(<SID>buffer_list()) + 2
      \ })

command! FZFLines call fzf#run({
      \ 'source': reverse(<SID>buffer_lines()),
      \ 'sink': function('<SID>line_handler'),
      \ 'options': '--extended --nth=3..',
      \ 'down': '60%'
      \ })

command! FZFMru call fzf#run({
      \ 'source': reverse(<SID>mruall_list()),
      \ 'sink': 'e',
      \ 'options': '-m -x +s',
      \ 'down': '40%'
      \ })

command! FZFColo call fzf#run({
      \ 'source': map(split(globpath(&rtp, "colors/*.vim"), "\n"),
      \ "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
      \ 'sink': 'colo',
      \ 'options': '+m',
      \ 'left': '20%'
      \ })
