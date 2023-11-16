PROXY_HTTP_PORT=7890
PROXY_SOCKS_PORT=7890
if sh -c 'LANG=C ss -lntu | grep LISTEN.*7890' &>/dev/null; then
    PROXY_SERVER="127.0.0.1"
elif [ -f /.dockerenv ]; then
    PROXY_SERVER="172.17.0.1"
elif [[ $SHELL_PLATFORM == "WSL2" && -f /etc/resolv.conf ]]; then
    PROXY_SERVER=$(sed -n "s/^nameserver\s\(.*\)$/\1/p" /etc/resolv.conf)
else
    PROXY_SERVER="127.0.0.1"
fi

function proxy() {
    export https_proxy=http://$PROXY_SERVER:$PROXY_HTTP_PORT http_proxy=http://$PROXY_SERVER:$PROXY_HTTP_PORT all_proxy=socks5://$PROXY_SERVER:$PROXY_SOCKS_PORT no_proxy=localhost,127.0.0.0/8,*.local
    export HTTPS_PROXY=http://$PROXY_SERVER:$PROXY_HTTP_PORT HTTP_PROXY=http://$PROXY_SERVER:$PROXY_HTTP_PORT ALL_PROXY=socks5://$PROXY_SERVER:$PROXY_SOCKS_PORT NO_PROXY=localhost,127.0.0.0/8,*.local
}

function unproxy() {
    unset https_proxy
    unset http_proxy
    unset all_proxy
    unset no_proxy
    unset HTTPS_PROXY
    unset HTTP_PROXY
    unset ALL_PROXY
    unset NO_PROXY
}

proxy
