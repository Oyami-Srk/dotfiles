# TODO: improve performance

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if [[ -d "/usr/local/lib/node_modules/@hyperupcall/autoenv/" ]]; then
    function load_autoenv() {
        export AUTOENV_ENABLE_LEAVE=1
        local autoenv_dot_file="/usr/local/lib/node_modules/@hyperupcall/autoenv/activate.sh"
        if [[ -f $autoenv_dot_file ]]; then
            source $autoenv_dot_file
        fi
    }
    load_autoenv
fi

# Reload whole or partial part of env.d
function reload_env() {
    if [[ -z "$1" ]]; then
        echo "Reloading whole environment"
        if [ -d $HOME/.config/env.d ]; then
            for i in $HOME/.config/env.d/*.sh; do
                if [ -r $i ]; then
                    source $i
                fi
            done
            unset i
        fi
        echo "Reloaded whole environment"
    else
        echo "Reloading $1 environment"
        local target="$HOME/.config/env.d/$1"
        local found=""
        if [ -f "$target" -a -r "$target" ]; then
            source $target
            echo "Reloaded $target"
            found="1"
        elif [ -f "$target.sh" -a -r "$target.sh" ]; then
            source $target.sh
            echo "Reloaded $target.sh"
            found="1"
        fi
        if [ -z "$found" ]; then
            echo "$target nor $target.sh are both not presenting as readable regular file"
        fi
    fi
}
