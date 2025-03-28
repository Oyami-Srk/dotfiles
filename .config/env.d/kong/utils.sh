function lima_docker() {

}

function enable_emmy() {
    update_export KONG_EMMY_DEBUGGER=/Users/shiroko/Developments/emmy_core.dylib
    update_export KONG_EMMY_DEBUGGER_HOST=127.0.0.1
    update_export KONG_NGINX_WORKER_PROCESSES=1
}

function disable_emmy() {
    unset KONG_EMMY_DEBUGGER
    unset KONG_EMMY_DEBUGGER_HOST
    unset KONG_NGINX_WORKER_PROCESSES
}

function start_kong() {
    if [ -z "$KONG_PREFIX" -o ! -d "$KONG_PREFIX" ]; then
        echo "Must start_kong under venv. try automatically source venv script now."
        source ./bazel-bin/build/kong-dev-venv.sh
        if [ -n $KONG_PREFIX -a -d $KONG_PREFIX ]; then
            return -1
        fi
    fi

    rm -rf $KONG_PREFIX/logs
    kong migrations bootstrap
    kong start $(xargs <<<"$@")

    trap ctrl_c INT

    function ctrl_c() {
        kong stop $(xargs <<<"$@")
        echo "Kong stopped."
        trap - INT
    }

    tail -f $KONG_PREFIX/logs/${LOG_FILES:-*}
}

function last_nginx_pid() {
    ps -ef | grep "nginx: worker process" | grep -v "grep" | awk '{print $2}' | sort -nr | head -1
}

function last_nginx_path() {
    if [ "$SHELL_PLATFORM" = "Linux" ]; then
        ps --no-headers -o exe -p $(last_nginx_pid)
    else
        ps -p $(last_nginx_pid) | tail -1 | awk '{print $4}'
    fi
}

function last_nginx_resty_path() {
    local v=$(last_nginx_path)
    echo ${v%resty*}resty/bin/resty
}

function stapxx_fg() {
    local name="${1:-$(date +%s)}"
    local seconds="${2:-10}"
    local pid=$(last_nginx_pid)

    echo "Generating flamegraph on $pid for $seconds seconds and name it as $name"
    sudo PATH="$STAPXX_PATH:/usr/local/bin:$PATH" "$STAPXX_PATH/samples/lj-lua-stacks.sxx" --skip-badvars -x $pid --arg time=$seconds --arg detailed=1 |
        stackcollapse-stap.pl | flamegraph.pl >$name.svg
    # | perl -pe 's[builtin#(\d+)\n]["builtin#$1:". `'`last_nginx_resty_path`' "\$OR_DEV_UTILS_PATH/ljff.lua" $1`]ge' \
}

function average_rps() {
    local sum=0
    local count=0
    local first=0

    while IFS= read -r number; do
        if [ "$first" -eq 0 ]; then
            echo "$number (discard) "
            first=1
        else
            echo "$number"
            number=$(echo $number | grep -oP "[0-9.]*")
            sum=$((sum + number))
            count=$((count + 1))
        fi
    done

    if [ "$count" -ne 0 ]; then
        average=$(echo "scale=2; $sum / $count" | bc)
    else
        average=0
    fi

    average_result=$average
    echo "Average: $average_result"
}

function calculate_regression_rate() {
    local base=$1
    local target=$2
    local result=$(echo "scale=4; ($base - $target) / $base" | bc)
    result=$(echo "$result * 100" | bc)
    printf "Regression rate from $base to $target: %.2f%%\n" "$result"
}

function get_nginx_worker_for() {
    master_pid=$(ps -eo pid,args | grep 'nginx: master process' | grep "$1" | cut -d' ' -f 2)
    pgrep -aP ${master_pid} | grep 'nginx: worker process' | cut -d' ' -f 1
}

function dbeaver_to_kong() {
    local db=${1:-kong}
    /Applications/DBeaver.app/Contents/MacOS/dbeaver -con "driver=postgresql|database=$db|host=localhost|port=$KONG_PG_PORT|user=kong" -q -disconnectAll -bringToFront
}

function load_kong_env_for() {
    local usage="usage: load_kong_env_for [--with-incr-sync[=on|off]] [--with-log-<level>] <role>"

    local ENV_DIR="$HOME/.config/env.d/kong/envs"
    source "$ENV_DIR"/basic.env

    if [[ ! -d "$KONG_HOME" ]]; then
        echo "KONG_HOME ($KONG_HOME) is missing, create it first."
        mkdir -p "$KONG_HOME"
    fi

    local to_check=(KONG_LICENSE_PATH KONG_CLUSTER_CERT KONG_CLUSTER_CERT_KEY)
    for var in "${to_check[@]}"; do
        if [[ ! -f "${(P)var}" ]]; then
            echo "[warn] $var is missing"
        fi
    done

    while [[ $# -gt 1 ]]; do
        key="$1"
        case $key in
        --with-incr-sync*)
            # If use =on|off, set it to given value
            if [[ "$key" == *=* ]]; then
                export KONG_INCREMENTAL_SYNC=${key#--with-incr-sync=}
            else
                export KONG_INCREMENTAL_SYNC=on
            fi
            export KONG_INCREMENTAL_SYNC=$KONG_CLUSTER_RPC_SYNC
            ;;
        --with-log-*)
            export KONG_LOG_LEVEL=${key#--with-log-}
            ;;
        *)
            echo "Invalid option: $key"
            return 1
            ;;
        esac
        shift
    done

    local role=$1

    if [[ -z "$role" ]]; then
        echo "$usage"
        return 1
    fi

    if [[ "$role" == "basic" ]]; then
        echo "Loading basic.env"
    else
        if [[ -f "$ENV_DIR/$role.env" ]]; then
            echo "Loading $role.env"
            source "$ENV_DIR"/$role.env
        else
            echo "Invalid role: $role"
            return 1
        fi
    fi
}
