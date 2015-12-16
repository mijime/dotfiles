#!/bin/bash

###
# bash
###

mysh_color() {
  echo "\[\e[0;3${1}m\]"
}

mysh_prompt_ps1() {
  PS1="${MYSH_COLO[7]}\\u${MYSH_COLO[8]}@${MYSH_COLO[5]}\\h ${MYSH_COLO[4]}[\\w]\n${prompt_git}${prompt_status}$\[\e[0;00m\] "
}

mysh_prompt() {
  MYSH_COLO=("" $(seq 0 7|while read n; do mysh_color ${n}; done))

  alias cd='mysh_cd'
  alias pd='popd'

  PROMPT_COMMAND=mysh_prompt_update
  shopt -u histappend
  HISTSIZE=9999
  HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
  HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
  HISTCONTROL='ignoredups:ignorespace:erasedups'
}

declare -a MYSH_COLO=()
export MYSH_COLO

mysh_prompt $@
