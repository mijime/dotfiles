let b:plugged = expand('~/.vim/pack/plugged/opt')
if has('vim_starting')
  if !isdirectory(join([b:plugged, 'vim-plug'], '/'))
    echo 'install.. vim-plug'
    call system(join([
          \ 'git', 'clone', '--depth', '999',
          \ 'https://github.com/junegunn/vim-plug.git',
          \ join([b:plugged, 'vim-plug/autoload'], '/')], ' '))
    echo 'installed vim-plug'
  end
  packadd vim-plug
end

call plug#begin(b:plugged)
Plug 'Quramy/tsuquyomi', {'for': ['typescript']}
      \ | Plug 'Shougo/vimproc.vim', {'do': 'make'}
Plug 'Raimondi/delimitMate'
Plug 'Shougo/neocomplete.vim'
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterEnable']}
Plug 'artur-shaik/vim-javacomplete2', {'for': ['java']}
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}
Plug 'haya14busa/vim-auto-programming'
Plug 'itchyny/lightline.vim'
Plug 'jnwhiteh/vim-golang', {'for': ['go']}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim', {'on': ['Buffers', 'Lines', 'Files']}
Plug 'junegunn/goyo.vim', {'on': ['Goyo']}
Plug 'junegunn/gv.vim', {'on': ['GV']}
Plug 'junegunn/limelight.vim', {'on': ['Limelight']}
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)', 'EasyAlign']}
Plug 'junegunn/vim-plug', {'dir': join([b:plugged, 'vim-plug/autoload'], '/')}
Plug 'kana/vim-metarw'
Plug 'kannokanno/previm', {'for': ['markdown']}
Plug 'kchmck/vim-coffee-script', {'for': ['coffee']}
Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
Plug 'mattn/emmet-vim', {'for': ['html', 'html5', 'jsx']}
Plug 'mijime/vim-metarw-docker'
Plug 'mijime/vim-tmux', {'on':['Tmux', 'TmuxVim']}
Plug 'netrw.vim'
Plug 'othree/yajs.vim', {'for': ['javascript']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
Plug 'tpope/vim-fugitive'
Plug 'tyru/open-browser.vim', {'for': ['markdown']}
Plug 'vim-scripts/jade.vim', {'for': ['jade']}
call plug#end()
unl b:plugged
