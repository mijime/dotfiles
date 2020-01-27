Plug 'previm/previm', {'for':['markdown']} |
      \ Plug 'tyru/open-browser.vim'
augroup MyMarkdown
  au!
  autocmd FileType markdown setlocal sw=2 sts=2 ts=2 et
augroup END

Plug 'tpope/vim-speeddating', {'for':['org']}
Plug 'jceb/vim-orgmode', {'for':['org']}
let g:org_agenda_files=['~/org/*.org']
