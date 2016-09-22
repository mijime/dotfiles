#!/usr/bin/zsh

[[ -d ~/.fzf ]] || { \
  git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf; \
  ~/.fzf/install --bin; \
}
export PATH=${PATH}:~/.fzf/bin
[[ -d ~/.dotfiles ]] || git clone --depth 1 https://github.com/mijime/dotfiles ~/.dotfiles

for shrc in \
  ~/.fzf/shell/*.zsh \
  ~/.dotfiles/shrc.d/*/*.sh \
  ~/.dotfiles/shrc.d/*/*.zsh \
  ~/.zshrc.local
do
  if [[ -f ${shrc} ]]
  then source "${shrc}"
  fi
done
