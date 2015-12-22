#!/bin/bash

###
# common
#
###

__mysh__prompt_update() {
  local ret=$?
  local -a __colo=()
  local prompt_git= prompt_status=

  __mysh__color
  if [[ 0 -eq ${ret} ]]
  then
    prompt_status="${__colo[7]}"
  else
    prompt_status="${__colo[2]}"
  fi

  prompt_git="${__colo[2]}$(__mysh__prompt_git)"

  __mysh__prompt_ps1
}

__mysh__prompt_git() {
  git status --porcelain --branch 2>/dev/null \
    | awk '/^##/{branch=$2}END{if(NR>0){print"("branch,NR-1") "}}'
}

__mysh__select() {
  local select_commands=($(echo ${MYSH_FILTER:-fzf:grep}|sed 's/:/ /g'))

  for select_command in ${select_commands[@]}
  do
    hash ${select_command} 1>/dev/null 2>/dev/null || continue

    case ${select_command} in
      fzf)
        ${select_command} --extended --query="${@}"
        return ;;
      peco)
        ${select_command} --layout bottom-up --query="${@}"
        return ;;
      *)
        ${select_command} "${@}" | head -n 1
        return ;;
    esac
  done
}

__mysh__cd() {
  [[ $# -eq 0 ]] && pushd "${HOME}" > /dev/null

  while [[ $# -gt 0 ]]
  do
    case "${1}" in
      -c|--clear)
        dirs -c
        break
        ;;
      -l|--list)
        dirs -l -v | awk '!nl[$2]{print;nl[$2]=1}'
        break
        ;;
      -e|--export)
        dirs -l -v | sed -e 's/^[[:cntrl:]0-9 ]*//g' | awk '!nl[$0]{print;nl[$0]=1}'
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
      --*)
        local cd_plugin=${1#--}
        shift
        "__mysh__cd_${cd_plugin}" "$@"
        return
        ;;
      -)
        pushd > /dev/null
        shift || break
        ;;
      -*)
        pushd $@
        return
        ;;
      *)
        if [[ -d "${1}" ]]
        then
          pushd "${1}" > /dev/null
          shift || break
        else
          __mysh__cd_missed "$@"
          return
        fi
        ;;
    esac
  done
}

__mysh__cd_select() {
  local target_dir="$(dirs -l -v | awk '!nl[$2]{print;nl[$2]=1}' | __mysh__select "${@}" | sed -e 's/^[[:cntrl:]0-9 ]*//g')"
  if [[ -z "${target_dir}" ]]
  then
    return 1
  fi

  cd "${target_dir}"
}

__mysh__cd_missed() {
  local target_dir="$({ dirs -l -v | awk '!nl[$2]{print;nl[$2]=1}' | sed -e 's/^[[:cntrl:]0-9 ]*//g'; find -type d; } | __mysh__select "${@}")"

  if [[ -z "${target_dir}" ]]
  then
    return 1
  fi

  cd "${target_dir}"
}

alias cd='__mysh__cd'
