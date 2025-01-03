function git-remove-all-untracked() {
    local list=$(git status --short | awk '$1 == "??" { $1=""; print substr($0, 2) }') 
    if [[ -z "$list" ]]; then
        echo "Nothing to clean"
    else
        echo "$list"
        echo "Remove all file/directory by rm -rf, Ok? [y/n] "
        if $(read -qs); then
            echo "$list" | xargs -I {} rm -rf {}
        else
            return
        fi
    fi
}

function remote_tmux() {
    ssh "$1" -- tmux ${@:2}
}

alias rt='remote_tmux'

function rta() {
    rt "${1:-${DEFAULT_HOST}}" attach -t
}

function rtd() {
    rt "${1:-${DEFAULT_HOST}}" attach -d -t
}

function rtl() {
    rt "${1:-${DEFAULT_HOST}}" list-sessions
}

function rtaa() {
    if [[ ${#@} == 0 ]]; then
        rt "${DEFAULT_HOST}" new-session -As "default"
    elif [[ ${#@} == 1 ]]; then
        rt "${DEFAULT_HOST}" new-session -As "$1"
    else
        rt "$1" new-session -As "$2"
    fi
}
