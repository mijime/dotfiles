#!/bin/bash

###
# common
#
###

__mysh__prompt_update() {
  local ret=$?
  local -a __colo=()
  local prompt_vcs= prompt_status=

  __mysh__color
  if [[ 0 -eq ${ret} ]]
  then
    prompt_status="${__colo[7]}"
  else
    prompt_status="${__colo[2]}"
  fi

  prompt_vcs="${__colo[2]}$(__mysh__prompt_git)$(__mysh__prompt_svn)"

  __msyh__share_history
  __mysh__prompt_ps1
}

__mysh__prompt_git() {
  if [[ -z "${PROMPT_NO_GIT}" ]]
  then git status --porcelain --branch 2>/dev/null | awk 'NR==1{b=$2}END{if(NR>0)print"("b,NR-1") "}'
  else git describe --all --tags --always 2>/dev/null | awk '{print"("$0") "}'
  fi
}

__mysh__prompt_svn() {
  if [[ -z "${PROMPT_NO_SVN}" ]]
  then svn info --show-item relative-url 2>/dev/null | awk '{print"("$0") "}'
  fi
}
