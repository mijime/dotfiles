#!/usr/bin/zsh

[[ -d ~/.fzf ]] || git clone --depth 1 https://github.com/junegunn/fzf ~/.fzf
[[ -d ~/.dotfiles ]] || git clone --depth 1 https://github.com/mijime/dotfiles ~/.dotfiles

for shrc in \
  ~/.dotfiles/shrc.d/*/*.sh \
  ~/.dotfiles/shrc.d/*/*.zsh \
  ~/.fzf/shell/*.zsh \
  ~/.zshrc.local
do
  if [[ -f ${shrc} ]]
  then source "${shrc}"
  fi
done
