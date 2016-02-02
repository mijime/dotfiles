[[ -d ~/.sham ]] || git clone https://github.com/mijime/sham ~/.sham

source ~/.sham/sham.zsh

export SHAM_HOME=~/.sham/tmp/zsh

sham 'mijime/sham'     dir: ~/.sham
sham 'mijime/dotfiles' dir: ~/.dotfiles of:'shrc.d/*/*.{sh,zsh} .shrc.d/*.sh'
sham 'junegunn/fzf'    dir: ~/.fzf      of:'shell/*.zsh' use:'bin/*' do:'./install --bin'
sham 'zsh-users/zsh-history-substring-search' of:'*.zsh'

sham list 2>/dev/null || sham install --verbose
sham load --verbose

[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
