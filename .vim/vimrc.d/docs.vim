Plug 'previm/previm', {'for':['markdown']} |
      \ Plug 'tyru/open-browser.vim', {'for':['markdown']}
let g:previm_plantuml_imageprefix = 'http://plantuml.local.gd/svg/'
Plug 'masukomi/vim-markdown-folding', {'for':['markdown']}
let g:markdown_fold_override_foldtext = 0
let g:markdown_fold_style = 'nested'

augroup MyMarkdown
  autocmd!
  autocmd FileType markdown setlocal sw=2 sts=2 ts=2 et
augroup END

Plug 'tpope/vim-speeddating', {'for':['org']}
Plug 'jceb/vim-orgmode', {'for':['org']}
let g:org_agenda_files=split(expand('$HOME/.org/**/*.org'), '\n')

augroup MyOrg
  autocmd!
  autocmd FileType org let b:did_ftplugin=1
  autocmd FileType org set conceallevel=0
augroup END

Plug 'glidenote/memolist.vim', {'on':['MemoNew', 'MemoList', 'MemoGrep']}
let g:memolist_path = '$HOME/.org'
let g:memolist_fzf = 1
let g:memolist_template_dir_path = "~/.vim/templates/memolist"
let g:memolist_memo_date = '%Y-%m-%dT%H:%M:%S%z'
let g:memolist_filename_date = '%Y/%m/%d/'
let g:memolist_memo_suffix = "org"
