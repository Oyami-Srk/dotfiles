if [ $SHELL_PLATFORM != "Linux" ] || [ ! -f /etc/lsb-release ]; then
    return
fi

# environment profiles
if [ -d $HOME/.config/env.d/deepin ]; then
    for i in $HOME/.config/env.d/deepin/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi
