for bashrc in /etc/bash_completion
    do
      if [[ -z ${BASH_DEBUG} ]]
      then [ ! -f ${bashrc} ] || source ${bashrc} || echo Loading Error: ${bashrc} >&2
      else echo source ${bashrc} >&2
      [ ! -f ${bashrc} ] || time source ${bashrc} || echo Loading Error: ${bashrc} >&2
      fi
done

case ${TERM} in
screen|cygwin|xterm*)
    for bashrc_d in ${HOME}/.bashrc.d
        do [ -d ${bashrc_d}/ ] && \
            for bashrc in $(find ${bashrc_d}/ -type f -name '*.sh')
                do
                  if [[ -z ${BASH_DEBUG} ]]
                  then source ${bashrc} || echo Loading Error: ${bashrc} >&2
                  else echo source ${bashrc} >&2
                  time source ${bashrc} || echo Loading Error: ${bashrc} >&2
                  fi
            done
    done
    ;;
esac

export PATH=${PATH}:node_modules/.bin:${HOME}/.bin

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
