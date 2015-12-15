#!/bin/zsh

###
# zsh
###

mysh_color() {
  echo "%F{${1}}"
}

mysh_prompt_ps1() {
  PROMPT="${prompt_status}$%f "
  RPROMPT="${prompt_git}${MYSH_COLO[7]}%n${MYSH_COLO[8]}@${MYSH_COLO[5]}%m ${MYSH_COLO[4]}[%~]"
}

mysh_prompt() {
  typeset -g -a MYSH_COLO

  MYSH_COLO=($(seq 0 7|while read n; do mysh_color ${n}; done))
  export MYSH_COLO

  alias cd='mysh_cd'
  alias pd='popd'

  precmd_functions=(mysh_prompt_update)
  setopt hist_ignore_dups
  bindkey -e
  bindkey "^P" history-beginning-search-backward
  bindkey "^N" history-beginning-search-forward
  HISTFILE=~/.zsh_history
  HISTSIZE=9999
  SAVEHIST=9999
}

mysh_prompt $@
