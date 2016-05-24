#!/bin/bash

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
alias filter='__mysh__select'
