__ZSH_SECRET_UNSEAL_PROMPT='%F{red}%B%b%f'

function do_seal_for() {
    local do_=""
    if [[ "$1" == "seal" ]]; then
        for i in $(cat "$2" | cut -d'=' -f1); do
            unset "$i"
        done
    else
        eval $(cat "$2" | op inject)
    fi
}

function do_seal() {
    if [ -z "$2" ]; then
        for i in "$HOME/.config/env.d/secret"/*.secret.env; do
            if [ -r "$i" ]; then
                echo "${(C)1}ing $(basename $i | sed 's/.secret.env//')"
                do_seal_for "$1" "$i"
            fi
        done
    else
        local i="$HOME/.config/env.d/secret/$2.secret.env"
        if [ -r "$i" ]; then
            echo "${(C)1}ing $(basename $i | sed 's/.secret.env//')"
            do_seal_for "$1" "$i"
        fi
    fi
}

function unseal() {
    if [ ! -z $__ZSH_SECRET_UNSEALED ]; then
        echo "Secrets is alreay unsealed."
        return
    fi

    export PS1="$__ZSH_SECRET_UNSEAL_PROMPT $PS1"
    export __ZSH_SECRET_UNSEALED=1

    do_seal "unseal" "$1"
}

function seal() {
    if [ -z $__ZSH_SECRET_UNSEALED ]; then
        echo "Secrets is alreay sealed."
        return
    fi

    export PS1="$(echo $PS1 | sed "s/^$__ZSH_SECRET_UNSEAL_PROMPT //")"
    unset __ZSH_SECRET_UNSEALED

    if [ -z "$1" ]; then
        for i in "$HOME/.config/env.d/secret"/*.secret.env; do
            if [ -r "$i" ]; then
            fi
        done
    else
        local f="$HOME/.config/env.d/secret/$1.secret.env"
        if [ -r "$f" ]; then
            cat "$f" | cut -d'=' -f1 | xargs -I {} unset {}
        fi
    fi

    do_seal "seal" "$1"
}
