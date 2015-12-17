export DOTFILES=${DOTFILES:-~/.dotfiles}

case ${TERM} in
  screen|cygwin|xterm*)
    bashrcd=$(ls -1pd ${DOTFILES}/{.shrc.d/*.sh,shrc.d/*/*.{sh,bash}})
    for bashrc in ${bashrcd[@]}
    do source "${bashrc}" || echo Loading Error: ${bashrc} >&2
    done
    ;;
esac

export PATH="${PATH}:node_modules/.bin:${DOTFILES}/.bin"

[[ ! -f ~/.bashrc.local ]] || source ~/.bashrc.local
