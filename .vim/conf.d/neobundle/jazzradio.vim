NeoBundleLazy 'supermomonga/jazzradio.vim',{'depends': ['Shougo/unite.vim']}
if neobundle#tap('jazzradio.vim')
  call neobundle#config({
  \  'autoload': {
  \    'unite_sources': ['jazzradio'],
  \    'commands': [
  \      'JazzradioUpdateChannels',
  \      'JazzradioStop',
  \      {
  \        'name': 'JazzradioPlay',
  \        'complete': 'customlist,jazzradio#channel_key_complete'
  \      }
  \    ],
  \    'function_prefix': 'jazzradio'
  \  }
  \})
endif

nnoremap <silent> [unite]j :<C-u>Unite<Space>jazzradio<CR>
