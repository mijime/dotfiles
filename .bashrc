export DOTFILES=~/.dotfiles

case ${TERM} in
  screen|cygwin|xterm*)
    bashrcd=$(ls -1pd ${DOTFILES}/{.bashrc.d/*.sh,shrc.d/*/*.{sh,bash}})
    for bashrc in ${bashrcd[@]}
    do source "${bashrc}" || echo Loading Error: ${bashrc} >&2
    done
    ;;
esac

export PATH="${PATH}:node_modules/.bin:${DOTFILES}/.bin"
