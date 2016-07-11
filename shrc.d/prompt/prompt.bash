#!/bin/bash

###
# bash
###

__mysh__color() {
  __colo=("" $(seq 0 7|while read n; do echo "\[\e[0;3${n}m\]"; done))
}

__mysh__prompt_ps1() {
  PS1="${__colo[7]}\\u${__colo[8]}@${__colo[5]}\\h ${__colo[4]}[\\w] ${__colo[3]}\t\n${prompt_vcs}${prompt_status}$\[\e[0;00m\] "
}

__msyh__share_history(){
  history -a
  history -c
  history -r
}

__mysh__prompt() {
  PROMPT_COMMAND=__mysh__prompt_update
  shopt -u histappend
  HISTSIZE=100000
  HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
  HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
  HISTCONTROL='ignoredups:ignorespace:erasedups'
}

__mysh__prompt $@
