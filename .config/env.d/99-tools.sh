if [ -d $HOME/.config/env.d/tools ]; then
    for i in $HOME/.config/env.d/tools/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi
