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
Plug 'junegunn/vim-plug', {'dir': join([b:plugged, 'vim-plug/autoload'], '/')}
Plug 'Quramy/tsuquyomi', {'for': ['typescript']}
Plug 'Raimondi/delimitMate', {'on': ['PlugAllLoad']}
Plug 'Shougo/neocomplete.vim', {'on': ['PlugAllLoad']}
Plug 'airblade/vim-gitgutter', {'on': ['GitGutterEnable']}
Plug 'editorconfig/editorconfig-vim', {'on': ['PlugAllLoad']}
Plug 'elixir-lang/vim-elixir', {'for': ['elixir']}
Plug 'haya14busa/vim-auto-programming', {'on': ['PlugAllLoad']}
Plug 'itchyny/lightline.vim', {'on': ['PlugAllLoad']}
Plug 'fatih/vim-go', {'for': ['go']}
Plug 'junegunn/fzf.vim', {'on': ['Buffers', 'Lines', 'Files']}
      \ | Plug 'junegunn/fzf',
      \ {'on': ['Buffers', 'Lines', 'Files'], 'do': './install --bin'}
Plug 'junegunn/goyo.vim', {'on': ['Goyo']}
Plug 'junegunn/gv.vim', {'on': ['GV']}
Plug 'junegunn/limelight.vim', {'on': ['Limelight']}
Plug 'junegunn/seoul256.vim', {'on': ['PlugAllLoad']}
Plug 'junegunn/vim-easy-align', {'on': ['<Plug>(EasyAlign)', 'EasyAlign']}
Plug 'kana/vim-metarw', {'on': ['PlugAllLoad']}
Plug 'kannokanno/previm', {'for': ['markdown']}
Plug 'kchmck/vim-coffee-script', {'for': ['coffee']}
Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
Plug 'mattn/emmet-vim', {'for': ['html', 'html5', 'jsx']}
Plug 'mijime/vim-metarw-docker', {'on': ['PlugAllLoad']}
Plug 'mijime/vim-tmux', {'on': ['Tmux', 'TmuxVim']}
Plug 'netrw.vim'
Plug 'othree/yajs.vim', {'for': ['javascript']}
Plug 'plasticboy/vim-markdown', {'for': ['markdown']}
Plug 'tpope/vim-fugitive', {'on': ['PlugAllLoad']}
Plug 'tyru/open-browser.vim', {'for': ['markdown']}
Plug 'vim-scripts/jade.vim', {'for': ['jade']}
Plug 'keith/swift.vim', {'for': ['swift']}
call plug#end()
unl b:plugged
