[[ -d ~/.sham ]] || git clone https://github.com/mijime/sham ~/.sham

source ~/.sham/sham.zsh

export SHAM_HOME=~/.sham/tmp/zsh

sham "zsh-users/zsh-history-substring-search" of:"*.zsh"
sham "mijime/dotfiles" dir: ~/.dotfiles of:".shrc.d/*.sh shrc.d/*/*.{sh,zsh}"
sham "junegunn/fzf"    dir: ~/.fzf of:"shell/*.zsh" use:"bin/*" post:"./install --all"
sham list 2>/dev/null || sham install --verbose
sham load --verbose

[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
