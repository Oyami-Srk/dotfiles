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
