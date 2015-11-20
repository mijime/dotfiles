Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \ 'mode_map': {'c': 'NORMAL'},
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \ },
      \ 'component_func': {
      \ 'modified':     '<SID>LightLineModified',
      \ 'readonly':     '<SID>LightLineReadonly',
      \ 'fugitive':     '<SID>LightLineFugitive',
      \ 'filename':     '<SID>LightLineFilename',
      \ 'fileformat':   '<SID>LightLineFileformat',
      \ 'filetype':     '<SID>LightLineFiletype',
      \ 'fileencoding': '<SID>LightLineFileencoding',
      \ 'mode':         '<SID>LightLineMode'
      \ }}

func! <SID>LightLineModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endf

func! <SID>LightLineReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endf

func! <SID>LightLineFilename()
  return ('' != <SID>LightLineReadonly() ? <SID>LightLineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != <SID>LightLineModified() ? ' ' . <SID>LightLineModified() : '')
endf

func! <SID>LightLineFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endf

func! <SID>LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endf

func! <SID>LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endf

func! <SID>LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endf

func! <SID>LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endf
