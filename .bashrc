[[ -d ~/.sham ]] || git clone https://github.com/mijime/sham ~/.sham

source ~/.sham/sham.bash

export SHAM_HOME=~/.sham/tmp/bash

sham "mijime/dotfiles" dir: ~/.dotfiles of:".shrc.d/*.sh shrc.d/*/*.{sh,bash}"
sham "junegunn/fzf"    dir: ~/.fzf of:"shell/*.bash" use:"bin/*" post:"./install --all"
sham list 2>/dev/null || sham install --verbose
sham load --verbose

[[ ! -f ~/.bashrc.local ]] || source ~/.bashrc.local

export PATH="${PATH}:node_modules/.bin:${DOTFILES}/.bin"
[[ ! -f ~/.bashrc.local ]] || source ~/.bashrc.local

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
