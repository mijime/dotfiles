Plug 'previm/previm', {'for':['markdown']} |
      \ Plug 'tyru/open-browser.vim', {'for':['markdown']}
let g:previm_plantuml_imageprefix = 'http://plantuml.local.gd/svg/'

augroup MyMarkdown
  au!
  autocmd FileType markdown setlocal sw=2 sts=2 ts=2 et
augroup END

Plug 'tpope/vim-speeddating', {'for':['org']}
Plug 'jceb/vim-orgmode', {'for':['org']}
let g:org_agenda_files=['~/org/*.org']

Plug 'glidenote/memolist.vim', {'on':['MemoNew', 'MemoList', 'MemoGrep']}
let g:memolist_path = '$HOME/.config/memo/_posts'
let g:memolist_fzf = 1
let g:memolist_template_dir_path = "~/.vim/templates/memolist"
let g:memolist_memo_date = '%Y-%m-%dT%H:%M:%S%z'
let g:memolist_memo_suffix = "md"
