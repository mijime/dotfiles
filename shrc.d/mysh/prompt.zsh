#!/bin/zsh

###
# zsh
###

mysh_color() {
  __colo=($(seq 0 7|while read n; do echo "%F{${n}}"; done))
}

mysh_prompt_ps1() {
  PROMPT="${prompt_status}$%f "
  RPROMPT="${prompt_git}${__colo[7]}%n${__colo[8]}@${__colo[5]}%m ${__colo[4]}[%~]"
}

mysh_prompt() {
  alias cd='mysh_cd'
  alias pd='popd'

  precmd_functions=(mysh_prompt_update)
  setopt EXTENDED_HISTORY
  setopt hist_expand
  setopt hist_ignore_all_dups
  setopt hist_ignore_dups
  setopt hist_ignore_space
  setopt hist_no_store
  setopt hist_reduce_blanks
  setopt hist_save_no_dups
  setopt hist_verify
  setopt inc_append_history
  setopt share_history
  bindkey -e
  bindkey "^N" history-beginning-search-backward
  bindkey "^P" history-beginning-search-forward
  HISTFILE=${HOME}/.zsh_history
  HISTSIZE=1000
  SAVEHIST=100000
}

mysh_prompt $@
