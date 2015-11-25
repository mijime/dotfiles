#!/bin/bash

# [history]
__share_history(){
    history -a
    history -r
}

case ${SHELL} in
    *bash)
        shopt -u histappend
        export HISTSIZE=9999
        export HISTTIMEFORMAT='%y/%m/%d %H:%M:%S  '
        export HISTIGNORE='l[sla]:history:pwd:exit:cd:[bf]g:jobs'
        export HISTCONTROL='ignoredups:ignorespace:erasedups'
        ;;
    *zsh)
        HISTFILE=~/.zsh_history
        HISTSIZE=10000
        SAVEHIST=10000
        setopt hist_ignore_dups
        setopt share_history
        ;;
esac

# [prompt]
__git_info_ps1(){
  git status --porcelain --branch 2>/dev/null |
    awk '/^##/{branch=$2}END{if(NR>0){print" ("branch,NR-1")"}}'
}
__user_info_ps1="\[\e[36m\]\u\[\e[0m\]@\[\e[34m\]\h"

custom_prompt(){
  __shell_result=$?
  [[ 0 -eq ${__shell_result} ]] &&
    __shell_result_ps1="\[\e[0;32m\][${__shell_result}]" ||
    __shell_result_ps1="\[\e[0;31m\][${__shell_result}]"
  [[ -z ${__no_git_prompt} ]] || unset __git_ps1
  PS1="\[\e]0;\w\a\]${__user_info_ps1} \[\e[33m\]\w ${__shell_result_ps1}${__git_ps1}\n\[\e[0m\]\$ "
}

PROMPT_COMMAND='custom_prompt'

cd_func(){
  [[ $# -eq 0 ]] && popd > /dev/null

  while [[ $# -gt 0 ]]
  do
    case "$1" in
      -s|--save)
        dirs -v -l | awk '{print"pushd -n \""$2"\";"}'
        shift || break
        ;;
      -c|--clear)
        dirs -c
        shift || break
        ;;
      -l|--list)
        dirs -v -p | awk -v dispf="%3d %s\n" '!nl[$2]{nl[$2]=$1}END{for(k in nl)printf dispf,nl[k],k}' | sort -n
        shift || break
        ;;
      *)
        pushd "$1" > /dev/null
        __git_ps1="\[\e[0;31m\]$(__git_info_ps1)"
        shift || break
        ;;
    esac
  done
}

alias cd='cd_func'
alias pd='popd'
