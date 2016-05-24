#!/bin/bash

# Aliases
#
# Some example alias instructions
# If these are enabled they will be used instead of any instructions
# they may mask.  For example, alias rm='rm -i' will mask the rm
# application.  To override the alias instruction use a \ before, ie
# \rm will call the real rm not the alias.
#
# Interactive operation...
case ${OSTYPE} in
darwin*)
  # eval $(dircolors ${HOME}/.dir_colors)
  alias ls='ls --color'
  alias rm='mv --backup=numbered --target-directory="${TRASH_DIR}"'
  ;;

msys*)
  # stty -ixon -ixoff
  # eval $(dircolors ${HOME}/.dir_colors)
  alias ls='ls --color'
  alias rm='mv --backup=numbered --target-directory="${TRASH_DIR}"'

  export MSYS='winsymlinks'
  alias open=start
  ;;

cygwin*)
  # stty -ixon -ixoff
  # eval $(dircolors ${HOME}/.dir_colors)
  alias ls='ls --color'
  alias rm='mv --backup=numbered --target-directory="${TRASH_DIR}"'

  export CYGWIN='nodosfilewarning winsymlinks'
  alias open=cygstart
  alias apt-cyg='apt-cyg -u'
  ;;
esac

alias l='ls -CF'          #
alias la='ls -A'          # all but . and ..
alias ll='ls -l'
alias df='df -h'
alias du='du -h'
alias grep='grep --color' # show differences in colour
alias less='less -rN'     # raw control characters
alias mkdir='mkdir -p'
alias whence='type -a'    # where, of a sort

# alias cd='pushd'
# alias dirs='dirs -v'
# alias ansible-playbook='ANSIBLE_SSH_ARGS='-F ${HOME}/.ssh/config' ansible-playbook -c ssh'
# alias lmake='make -f ${HOME}/.Makefile'

export TRASH_DIR=${HOME}/.Trash/$(date +%F)
mkdir -p "${TRASH_DIR}"
alias clean_trash='time \rm -rfv "${TRASH_DIR}" && mkdir -p "${TRASH_DIR}"'

aliasf(){ alias | sed -e 's/^\([^=]*\)=\(.*\)/\1 => \2/' -e "s/'//g" | grep --color $@; }
