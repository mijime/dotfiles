for bashrc in /etc/bash_completion
    do [ ! -f $bashrc ] || source $bashrc || echo Loading Error: $bashrc >&2
done


case $TERM in
xterm*)
    for bashrc_d in ~/.bashrc.d
        do [ -d $bashrc_d/ ] && \
            for bashrc in $(find $bashrc_d/ -type f)
                do source $bashrc || echo Loading Error: $bashrc >&2
            done
    done
;;
esac
