#!/bin/bash

###
# common
#
###

mysh_prompt_update() {
  local ret=$?
  local prompt_git= prompt_status=

  if [[ 0 -eq ${ret} ]]
  then
    prompt_status="${MYSH_COLO[7]}"
  else
    prompt_status="${MYSH_COLO[2]}"
  fi

  prompt_git="${MYSH_COLO[2]}$(mysh_prompt_git)"

  mysh_prompt_ps1
}

mysh_prompt_git() {
  git status --porcelain --branch 2>/dev/null \
  | awk '/^##/{branch=$2}END{if(NR>0){print"("branch,NR-1") "}}'
}

mysh_filter() {
  local filter_commands=($(echo ${MYSH_FILTER:-fzf:grep}|sed 's/:/ /g'))

  for filter_command in ${filter_commands[@]}
  do
    hash ${filter_command} 1>/dev/null 2>/dev/null || continue

    case ${filter_command} in
      fzf)
        ${filter_command} --extended --query="${1}"
        return ;;
      peco)
        ${filter_command} --layout bottom-up --query="${1}"
        return ;;
      *)
        ${filter_command} "${1}" | head -n 1
        return ;;
    esac
  done
}

mysh_cd() {
  local target_dir=

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
      -e|--export)
        dirs -l -v | sed -e 's/^\w\+\s\+//g' | awk '!nl[$0]{print;nl[$0]=1}'
        break
        ;;
      -i|--import)
        shift
        eval $(cat "$@" | awk '{print"pushd","\""$0"\";"}') > /dev/null
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
        if [[ -d "${1}" ]]
        then
          target_dir="${1}"
        else
          target_dir=$(find . -type d -or -type l | mysh_filter "${1}")

          if [[ -z "${target_dir}" ]]
          then
            return 1
          fi
        fi
        pushd "${target_dir}" > /dev/null
        shift || break
        ;;
    esac
  done
}
