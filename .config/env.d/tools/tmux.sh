function remote_tmux() {
    ssh "$1" -- tmux ${@:2}
}

function rt() {
    remote_tmux "${1:-${DEFAULT_HOST}}" "${@:2}"
}

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

function get-ec2-ip() {
    INSTANCE_NAME="$1"

    if [[ -z "$INSTANCE_NAME" ]]; then
        echo "Usage: get_public_ip_by_name <instance-name>"
        return 1
    fi

    aws ec2 describe-instances \
        --filters "Name=tag:Name,Values=$INSTANCE_NAME" "Name=instance-state-name,Values=running" \
        --query "Reservations[*].Instances[*].PublicIpAddress" \
        --output text | head -n 1
}
