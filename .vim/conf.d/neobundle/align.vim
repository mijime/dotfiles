NeoBundleLazy 'junegunn/vim-easy-align', {
      \ 'autoload': {
      \   'commands' : ['EasyAlign'],
      \   'mappings' : ['<Plug>(EasyAlign)'],
      \ }}
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
