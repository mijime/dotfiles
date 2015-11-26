Plug 'glidenote/memolist.vim', {'on': ['MemoNew', 'MemoList', 'MemoGrep']}

let g:memolist_memo_suffix = 'md'
let g:memolist_path = '~/.vim/cache/memo'
let g:memolist_unite = 1
let g:memolist_unite_option = '-auto-preview -start-insert'
let g:memolist_unite_source = 'file_rec'

nnoremap <Leader>mg :<C-U>MemoGrep<CR>
nnoremap <Leader>ml :<C-U>MemoList<CR>
nnoremap <Leader>mn :<C-U>MemoNew<CR>
