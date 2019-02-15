#!/bin/bash

__install_brew(){
  mkdir -p "${HOME}/.brew"
  curl -sSL https://github.com/Homebrew/brew/archive/master.tar.gz \
    | tar xz --strip-components=1 -C "${HOME}/.brew"
}

export PATH=${HOME}/.brew/bin:${PATH}

if ! type brew 1>/dev/null 2>/dev/null
then __install_brew
fi

export HOMEBREW_CASK_OPTS='--appdir=~/Applications --fontdir=/Library/Fonts'
homebrew_prefix=$(brew --prefix)

for bash_completion in "${homebrew_prefix}/etc/bash_completion.d/"*
do
  if [[ -f ${bash_completion} ]]
  then source "${bash_completion}"
  fi
done

export PATH="${PATH}:${HOME}/bin"
export PATH="${homebrew_prefix}/bin:${PATH}"
export PATH="${homebrew_prefix}/opt/openssl/bin:${PATH}"
export PATH="${homebrew_prefix}/opt/coreutils/libexec/gnubin:${PATH}"
export MANPATH="${homebrew_prefix}/opt/coreutils/libexec/gnuman:${MANPATH}"

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
    pushd ~ || return 1
    return
  fi
  while [[ $# -gt 0 ]]
  do
    case $1 in
      -)
        popd 1>&2 || return 1
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
        pushd "$1" >/dev/null || return 1
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

__create_ssh_config() {
    local ssh_project=~/.ssh/projects
    local ssh_config=~/.ssh/config

    while [[ $# -gt 0 ]]
    do
        case $1 in
            --project|-p)
                ssh_project=$2
                shift 2 || return 2
                ;;

            --config|-c)
                ssh_config=$2
                shift 2 || return 2
                ;;

            *)
                echo "[ERROR] $@" 1>&2
                return 1
                ;;
        esac
    done

    mkdir -p "${ssh_project}"
    find "${ssh_project}" -name ssh_config \
        | sort \
        | xargs cat > "${ssh_config}"
}
__create_ssh_config "$@"

__create_ssh_private() {
  local ssh_project=${SSH_PROJECT:-~/.ssh/projects}
  local host=localhost
  local algo=ed25519

  while [[ $# -gt 0 ]]
  do
    case $1 in
      --project|-p)
        ssh_project=$2
        shift 2 || return 1
        ;;
      -t)
        algo=$2
        shift 2 || return 1
        ;;
      *)
        host=$1
        shift || return 1
        ;;
    esac
  done

  dir="${ssh_project}/$(echo "${host}"|awk -F. '{for(i=NF;i>0;i--)printf"%s%s",$i,i==1?"":"/"}'|sed -e 's|*|_|g')"
  mkdir -p "${dir}"

  keyname=${dir}/id_${algo}
  if [[ ! -f ${keyname} ]]
  then
    ssh-keygen -t "${algo}" -f "${keyname}" -N "" -C ""
  fi

  ssh_config=${dir}/ssh_config
  if [[ ! -f ${ssh_config} ]]
  then
    cat <<EOF > "${ssh_config}"
Host ${host}
  IdentityFile ${keyname}
EOF
  fi
}

shopt -u histappend
HISTSIZE=100000
HISTFILESIZE=100000
HISTTIMEFORMAT='[%y/%m/%d %H:%M:%S]  '
HISTIGNORE='l[sla]:history*:pwd:exit:cd:[bf]g:jobs'
HISTCONTROL='ignoredups:ignorespace:erasedups'
__prompt_cmd(){
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='__prompt_cmd'

for localrc in ~/.bashrc.local ~/.dockerrc
do
  if [[ -f ${localrc} ]]
  then source ${localrc}
  fi
done
