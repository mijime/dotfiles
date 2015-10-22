NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload' : {
      \   'mappings' : [['n', '\r']],
      \   'commands' : ['QuickRun']
      \ }}

let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 200,
      \ 'outputter/buffer/split' : ':botright 8sp',
      \ 'outputter' : 'multi:buffer:quickfix',
      \ 'hook/close_buffer/enable_empty_data' : 1,
      \ 'hook/close_buffer/enable_failure' : 1,
      \ }
nnoremap <expr><silent> <C-c> quickrun#is_running() ?
      \ quickrun#sweep_sessions() : "\<C-c>"
