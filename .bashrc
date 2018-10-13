for bash_completion in /usr/local/etc/bash_completion.d/* ~/.dockerrc
do
  if [[ -f ${bash_completion} ]]
  then source ${bash_completion}
  fi
done

export PATH=${PATH}:~/bin
export PATH="/usr/local/opt/openssl/bin:${PATH}"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

alias ls='ls --color'
alias ll='ls -l'
alias rm='mv -v --backup=numbered -t ~/.Trash'
alias cd=__cd

if type reattach-to-user-namespace 1>/dev/null 2>/dev/null
then alias tmux='reattach-to-user-namespace tmux'
fi

export GOPATH=${HOME}
export PS1='$(__ret_ps1)\u\e[0;00m@\e[0;34m\h\e[0;33m \w\e[0;31m$(__git_ps1)\e[0;35m $(date +%H:%M:%S)\e[0;00m\n$ '

__cd() {
  if [[ $# -eq 0 ]]
  then
    pushd ~
    return
  fi
  while [[ $# -gt 0 ]]
  do
    case $1 in
      -)
        popd 1>&2
        shift
        ;;
      -c|--clear)
        dirs -c
        shift
        ;;
      -l|--list)
        dirs -v | awk 'p[$2]!=1{print}{p[$2]=1}'
        shift
        ;;
      *)
        pushd "$1" >/dev/null
        shift
        ;;
    esac
  done
}

__ret_ps1() {
  ret=$?
  if [[ ${ret} -eq 0 ]]
  then printf '\e[0;32m'
  else printf '\e[0;31m'
  fi
  return ${ret}
}

__create__ssh_config() {
  if [[ -d ${HOME}/.ssh/projects ]]
  then
    find ${HOME}/.ssh/projects -type f -name 'ssh_config' \
      | xargs cat > ${HOME}/.ssh/config
  fi
}
__create__ssh_config

shopt -u histappend
HISTSIZE=100000
HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
HISTCONTROL='ignoredups:ignorespace:erasedups'
