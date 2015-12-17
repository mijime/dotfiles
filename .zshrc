[[ -d ~/.deplug ]] || git clone https://github.com/mijime/deplug ~/.deplug

source ~/.deplug/deplug.zsh

deplug "zsh-users/zsh-history-substring-search" of:"*.zsh"
deplug "mijime/dotfiles" of:".shrc.d/*.sh shrc.d/*/*.{sh,zsh}"
deplug install --verbose
deplug load    --verbose

[[ ! -f ~/.zshrc.local ]] || source ~/.zshrc.local
