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

  __msyh__share_history
  __mysh__prompt_ps1
}

__mysh__prompt_git() {
  if [[ -z "${PROMPT_NO_GIT}" ]]
  then git status --porcelain --branch 2>/dev/null | awk 'NR==1{b=$2}END{if(NR>0)print"("b,NR-1") "}'
  else git describe --all --tags --always 2>/dev/null | awk '{print"("$0") "}'
  fi
}

__mysh__select() {
  local -a select_commands=($(echo ${MYSH_FILTER:-fzf:peco:grep}|sed 's/:/ /g'))
  local -a queries=()
  local column=0
  local last=0

  while [[ $# -gt 0 ]]
  do
    case $1 in
      -c|--col*)
        column=$2
        shift 2 || break
        ;;
      --last)
        last=1
        shift || break
        ;;
      *)
        queries=("${queries[@]}" "$1")
        shift || break
        ;;
    esac
  done

  for select_command in ${select_commands[@]}
  do
    hash ${select_command} 1>/dev/null 2>/dev/null || continue

    case ${select_command} in
      fzf)
        ${select_command} --extended --query="${queries[@]}"
        return ;;
      peco)
        ${select_command} --layout bottom-up --query="${queries[@]}"
        return ;;
      *)
        ${select_command} "${queries[@]}" | head -n 1
        return ;;
    esac
  done | awk -v "last=${last}" -v "column=${column}" 'last==0{print$column}last==1{print$NF}'
}

__mysh__cd() {
  [[ $# -eq 0 ]] && pushd "${HOME}" > /dev/null
  local action=

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
          for action in ${__mysh__cd_missed[@]}
          do ${action} "${@}" && return
          done
          return
        fi
        ;;
    esac
  done

  for action in ${__mysh__cd_posted[@]}
  do ${action}
  done
}

__mysh__cd_import() {
  eval $(cat "$@" | awk '{print"pushd","\""$0"\";"}') > /dev/null
}

__mysh__cd_export() {
  dirs -l -v | sed -e 's/^[[:cntrl:]0-9 ]*//g' | awk '!nl[$0]{print;nl[$0]=1}'
}

__mysh__cd_select() {
  local target_dir="$({
    dirs -l -v | awk '!nl[$2]{print;nl[$2]=1}' | sed -e 's/^/H/g'
    find $(dirname "${@:-.}") -type d -maxdepth 3 2>/dev/null | grep -v '/\.\|node_modules' | sed -e 's/^/C /g'
  } | __mysh__select "${@}" | sed -e 's/^[CH][[:cntrl:]0-9 ]*//g')"

  if [[ -z "${target_dir}" ]]
  then
    return 1
  fi

  cd "${target_dir}"
}

__mysh__cd_missed=(__mysh__cd_select)
__mysh__cd_posted=()
alias cd='__mysh__cd'
alias filter='__mysh__select'
