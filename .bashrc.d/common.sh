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

__interactiveGrep(){
  commands=$(echo ${FILTER_COMMAND:-fzf:grep}|sed 's/:/ /g')
  for cmd in ${commands[@]}
  do
    hash ${cmd} 1>/dev/null 2>/dev/null || continue

    case ${cmd} in
      fzf)
        fzf --query="$1"
        return
        ;;
      *)
        ${cmd} "$1"
        return
        ;;
    esac
  done
}

__cdFunc(){
  [[ $# -eq 0 ]] && popd > /dev/null

  while [[ $# -gt 0 ]]
  do
    case "$1" in
      --load)
        dirs -c
        eval $(cat $2|grep "^pushd")
        break
        ;;
      -s|--save)
        dirs -v -l | awk '!nl[$2]{print;nl[$2]=1}' | sed -e 's/^ *[0-9]\+ */pushd -n "/' -e 's/$/";/g'
        break
        ;;
      -c|--clear)
        dirs -c
        break
        ;;
      -l|--list|--history)
        dirs -v | awk '!nl[$2]{print;nl[$2]=1}'
        break
        ;;
      [-+][0-9]*)
        pushd "$1" > /dev/null
        __git_ps1="\[\e[0;31m\]$(__git_info_ps1)"
        shift || break
        ;;
      -*)
        pushd $@
        break
        ;;
      *)
        [[ -d "$1" ]] && targetDir="$1" || targetDir=$(find . -type d|__interactiveGrep "$1"|head -1||break)
        pushd "${targetDir}" > /dev/null
        __git_ps1="\[\e[0;31m\]$(__git_info_ps1)"
        shift || break
        ;;
    esac
  done
}

alias cd='__cdFunc'
alias pd='popd'
