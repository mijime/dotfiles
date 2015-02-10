NeoBundleLazy 'mijime/jazzradio.vim', { 'depends' : [ 'Shougo/unite.vim' ] }
if neobundle#tap('jazzradio.vim')
  call neobundle#config({
  \   'autoload' : {
  \     'unite_sources' : [
  \       'jazzradio'
  \     ],
  \     'commands' : [
  \       'JazzradioUpdateChannels',
  \       'JazzradioStop',
  \       {
  \         'name' : 'JazzradioPlay',
  \         'complete' : 'customlist,jazzradio#channel_key_complete'
  \       }
  \     ],
  \     'function_prefix' : 'jazzradio'
  \   }
  \ })
endif
