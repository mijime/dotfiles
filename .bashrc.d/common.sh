#!/bin/bash

mysh::color::prefix::bash(){
echo "\033[3${1}m"
}

mysh::color::prefix::zsh(){
echo "%F{$((${1} + 1))}"
}

mysh::prompt::bash(){

__myshPromptInfoBash="${__myshColo[6]}\\u${__myshColo[7]}@${__myshColo[4]}\\h ${__myshColo[3]}[\\w]"
PROMPT_COMMAND=mysh::prompt::update
shopt -u histappend
HISTSIZE=9999
HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
HISTCONTROL='ignoredups:ignorespace:erasedups'
}

mysh::prompt::zsh(){

__myshPromptInfoZsh="${__myshColo[6]}%n${__myshColo[7]}@${__myshColo[4]}%m ${__myshColo[3]}[%~]"
precmd_functions=(mysh::prompt::update)
setopt hist_ignore_dups
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999
}

mysh::prompt::update::bash(){

PS1="${__myshPromptInfoBash}
${__myshPromptGit}${__myshPromptCodeColor}$\033[00m "
}

mysh::prompt::update::zsh(){

PROMPT="${__myshPromptCodeColor}$%f "
RPROMPT="${__myshPromptGit}${__myshPromptInfoZsh}"
}

mysh::prompt::git(){

git status --porcelain --branch 2>/dev/null |
awk '/^##/{branch=$2}END{if(NR>0){print"("branch,NR-1") "}}'
}

mysh::prompt::update(){

__myshPromptCode=$?
[[ 0 -eq ${__myshPromptCode} ]] &&
  __myshPromptCodeColor="${__myshColo[6]}" ||
  __myshPromptCodeColor="${__myshColo[1]}"

__myshPromptGit="${__myshColo[1]}$(mysh::prompt::git)"

mysh::prompt::update::${__mysh}
}

mysh::filter(){

local __myshCommands=($(echo ${FILTER_COMMAND:-fzf:grep}|sed 's/:/ /g'))

for cmd in ${__myshCommands[@]}
do
  hash ${cmd} 1>/dev/null 2>/dev/null || continue

  case ${cmd} in
    fzf)
      ${cmd} --extended --query="${1}"
      return ;;
    peco)
      ${cmd} --layout bottom-up --query="${1}"
      return ;;
    *)
      ${cmd} "${1}"
      return ;;
  esac
done
}

mysh::cd(){

[[ $# -eq 0 ]] && { pushd || pushd ${HOME}; } 1>/dev/null 2>/dev/null

while [[ $# -gt 0 ]]
do
  case "${1}" in
    -c|--clear)
      dirs -c
      break
      ;;
    -l|--list|--history)
      dirs -l -v | awk '!nl[$2]{print;nl[$2]=1}'
      break
      ;;
    [-+][0-9]*)
      pushd "${1}" > /dev/null
      shift || break
      ;;
    -*)
      pushd $@
      break
      ;;
    *)
      [[ -d "${1}" ]] && targetDir="${1}" || targetDir=$(find . -type d -or -type l|mysh::filter "${1}"|head -1||break)
      pushd "${targetDir}" > /dev/null
      shift || break
      ;;
  esac
done
}

__mysh=${SHELL##*/}
__myshColo=($(seq 0 7|while read n; do mysh::color::prefix::${__mysh} ${n}; done))
mysh::prompt::${__mysh}

alias cd='mysh::cd'
alias pd='popd'
