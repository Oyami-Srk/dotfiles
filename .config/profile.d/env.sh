# TODO: improve performance

if [[ -d "$HOME/.pyenv" ]]; then
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if [[ -d "$HOME/.config/nvm" ]]; then
    export NVM_DIR="$HOME/.config/nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

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

if [[ -d "$HOME/.local/share/pnpm" ]]; then
    export PNPM_HOME="$HOME/.local/share/pnpm"
    case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
fi
