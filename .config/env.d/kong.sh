if [ "$ZSH_ENV_OPT_I_AM_KONGER" = "1" ]; then
    if [ -d $HOME/.config/env.d/kong ]; then
        for i in $HOME/.config/env.d/kong/*.sh; do
            if [ -r $i ]; then
                source $i
            fi
        done
        unset i
    fi
fi
