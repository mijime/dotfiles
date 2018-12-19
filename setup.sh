#!/bin/bash -xue

declare -a dotfiles=()
declare basedir=${0%/*}

dotfiles=(
  .bash_profile
  .bashrc
  .gitconfig
  .inputrc
  .tmux.conf
  .vim
)

main() {
  validation
  install_dotfiles
  install_config
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
    echo ${dotfile}
  done \
    | sed -e "s@^@${basedir}/@g" -e "s@${HOME}/@@g" \
    | while read dotfile
      do
        ln -sf "${dotfile}" "${HOME}/"
      done
}

install_config() {
  mkdir -p ~/.config
  ln -sf $(dirname ${0})/config/* ~/.config
}

err() {
  local ret=$1

  shift
  echo $@ >&2
  exit ${ret}
}

main $@
