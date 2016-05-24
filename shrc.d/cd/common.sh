#!/bin/bash

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
