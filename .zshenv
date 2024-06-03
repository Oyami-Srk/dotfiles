# Zprof
[[ ! -z "${ZPROF}" ]] && zmodload zsh/zprof

# Useful functions
function try_prepend_if_dir_exists() {
    local var="$1"
    local dir="$2"
    if [ -d "$dir" ]; then
        eval "export $var=\"\$dir\${$var:+:\$$var}\""
    fi
}

function try_append_if_dir_exists() {
    local var="$1"
    local dir="$2"
    if [ -d "$dir" ]; then
        eval "export $var=\"\${$var:+\$$var:}\$dir\""
    fi
}

function update_export() {
    local p="$1"
    local name="${p%%=*}"
    local value="${p#*=}"
    if [[ -v "$name" ]]; then
        if [ ${(P)name} != $value ]; then
            echo "Updating "$name" to "$value" from "${(P)name}""
            export $name="$value"
        fi
    else
        export $name=$value
    fi
}

# Content of environment
SHELL_PLATFORM="$(uname 2>/dev/null)"
[[ "$SHELL_PLATFORM" == *NT* ]] && SHELL_PLATFORM="MSYS"
if [ $SHELL_PLATFORM = "Linux" ] && [ ! -z ${WSL_DISTRO_NAME} ]; then
    if [[ "$(cat /proc/interrupts)" ]]; then
        SHELL_PLATFORM="WSL2"
    else
        SHELL_PLATFORM="WSL1"
    fi
    export WSL_ROOT_PATH="\\\\wsl.localhost\\${WSL_DISTRO_NAME}"
fi
export SHELL_PLATFORM
export SSH_KEY_PATH="~/.ssh/id_rsa"

# environment profiles
if [ -d $HOME/.config/env.d ]; then
    for i in $HOME/.config/env.d/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi

[[ -f $(which nvim) ]] && export EDITOR="nvim"
