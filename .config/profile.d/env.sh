# TODO: improve performance

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
