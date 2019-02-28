#!/usr/bin/env bash

set -xue

declare -a dotfiles=()
declare basedir=${0%/*}

dotfiles=(
  .bash_profile
  .bashrc
  .gitconfig
  .inputrc
  .tmux.conf
  .vim
  .textlintrc
)

main() {
  validation
  install_dotfiles
}

validation() {
  if [[ ! "${basedir}" =~ / ]]
  then
    err 1 "Please run an absolute path: ${0}"
  fi
}

install_dotfiles() {
  for dotfile in "${dotfiles[@]}"
  do
    echo "${dotfile}"
  done \
    | sed -e "s@^@${basedir}/@g" -e "s@${HOME}/@@g" \
    | while read -r dotfile
      do
        ln -sf "${dotfile}" "${HOME}/"
      done

  if [[ -f ~/.tmux.conf.local ]]
  then return
  fi

  case "$(uname)" in
  Darwin)
    cat > ~/.tmux.conf.local <<EOS
bind-key -T copy-mode-vi Enter             send-keys -X copy-selection-and-cancel
bind-key -T copy-mode-vi C-j               send-keys -X copy-selection-and-cancel
bind-key -T copy-mode-vi D                 send-keys -X copy-end-of-line
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-selection-and-cancel
bind-key -T copy-mode-vi A                 send-keys -X append-selection-and-cancel
EOS
    ;;
  *)
    touch ~/.tmux.conf.local
    ;;
  esac
}

err() {
  local ret=$1

  shift
  echo "$*" >&2
  exit "${ret}"
}

main "$@"
