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

    tail -f $KONG_PREFIX/logs/*
}
