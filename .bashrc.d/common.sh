#!/bin/bash

mysh:history:share(){
  history -a
  history -r
}

mysh:prompt:git(){
  git status --porcelain --branch 2>/dev/null |
  awk '/^##/{branch=$2}END{if(NR>0){print" ("branch,NR-1")"}}'
}

mysh:prompt(){
  __shell_result=$?
  [[ 0 -eq ${__shell_result} ]] &&
    __ps1_shell_result="\[\e[0;32m\][${__shell_result}]" ||
    __ps1_shell_result="\[\e[0;31m\][${__shell_result}]"
  [[ -z ${__ps1_git_ignore} ]] || unset __ps1_git
  PS1="\[\e]0;\w\a\]\[\e[36m\]\u\[\e[0m\]@\[\e[34m\]\h \[\e[33m\]\w ${__ps1_shell_result}${__ps1_git}\n\[\e[0m\]\$ "
}

mysh:update(){
  mysh:history:share
  __ps1_git="\[\e[0;31m\]$(mysh:prompt:git)"
}

mysh:filter(){
  commands=$(echo ${FILTER_COMMAND:-fzf:grep}|sed 's/:/ /g')
  for cmd in ${commands[@]}
  do
    hash ${cmd} 1>/dev/null 2>/dev/null || continue

    case ${cmd} in
      fzf)
        ${cmd} --extended --query="$1"
        return ;;
      peco)
        ${cmd} --query="$1"
        return ;;
      *)
        ${cmd} "$1"
        return ;;
    esac
  done
}

mysh:cd(){
  [[ $# -eq 0 ]] && { pushd || pushd $HOME; } 1>/dev/null 2>/dev/null

  while [[ $# -gt 0 ]]
  do
    case "$1" in
      -c|--clear)
        dirs -c
        break
        ;;
      -l|--list|--history)
        dirs -l -v | awk '!nl[$2]{print;nl[$2]=1}'
        break
        ;;
      [-+][0-9]*)
        pushd "$1" > /dev/null
        shift || break
        ;;
      -*)
        pushd $@
        break
        ;;
      *)
        [[ -d "$1" ]] && targetDir="$1" || targetDir=$(find . -type d|mysh:filter "$1"|head -1||break)
        pushd "${targetDir}" > /dev/null
        shift || break
        ;;
    esac
  done
  mysh:update
}

alias cd='mysh:cd'
alias pd='popd'
PROMPT_COMMAND='mysh:prompt'

case ${SHELL} in
  *bash)
    # shopt -u histappend
    export HISTSIZE=9999
    export HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
    export HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
    export HISTCONTROL='ignoredups:ignorespace:erasedups'
    ;;
  *zsh)
    HISTFILE=~/.zsh_history
    HISTSIZE=9999
    SAVEHIST=9999
    setopt hist_ignore_dups
    setopt history:share
    ;;
esac
