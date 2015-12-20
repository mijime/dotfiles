#!/bin/bash

###
# bash
###

mysh_color() {
  __colo=("" $(seq 0 7|while read n; do echo "\[\e[0;3${n}m\]"; done))
}

mysh_prompt_ps1() {
  PS1="${__colo[7]}\\u${__colo[8]}@${__colo[5]}\\h ${__colo[4]}[\\w]\n${prompt_git}${prompt_status}$\[\e[0;00m\] "
}

mysh_prompt() {

  alias cd='mysh_cd'
  alias pd='popd'

  PROMPT_COMMAND=mysh_prompt_update
  shopt -u histappend
  HISTSIZE=100000
  HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
  HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
  HISTCONTROL='ignoredups:ignorespace:erasedups'
}

mysh_prompt $@
