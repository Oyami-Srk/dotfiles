export PLATFORM="$(uname 2> /dev/null)"

export GOROOT=/usr/local/opt/go/libexec
# GOPAT为上面创建的目录路径
export GOPATH=$HOME/Projects/golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.config/ubin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export SSH_KEY_PATH="~/.ssh/id_rsa"

if [ $PLATFORM = "Darwin" ]; then
    # pipx
    export PATH="$PATH:$HOME/Library/Python/3.7/bin"
    # homebrew
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    if [ "x$TERM_PROGRAM" = "xiTerm.app" ]; then
        export PATH="$PATH:$HOME/.config/ubin/macos"
    fi

    alias pe='python-escpos'
    alias petxt='pe text --txt'
    alias pc='proxychains4 -q'
fi

# Check whether clash is start and export proxy env
if sh -c 'LANG=C netstat -an | grep "\(\.\|\:\)7890.*LISTEN"' &> /dev/null; then
    PROXY_SERVER=127.0.0.1
    HTTP_PORT=7890
    SOCKS_PORT=7891
    export https_proxy=http://$PROXY_SERVER:$HTTP_PORT http_proxy=http://$PROXY_SERVER:$HTTP_PORT all_proxy=socks5://$PROXY_SERVER:$SOCKS_PORT no_proxy=localhost,127.0.0.0/8,*.local
    export HTTPS_PROXY=http://$PROXY_SERVER:$HTTP_PORT HTTP_PROXY=http://$PROXY_SERVER:$HTTP_PORT ALL_PROXY=socks5://$PROXY_SERVER:$SOCKS_PORT NO_PROXY=localhost,127.0.0.0/8,*.local
    # if [ $PLATFORM = "Linux" ]; then
        # if which gsettings &> /dev/null; then
           # gsettings set org.gnome.system.proxy mode 'manual'
           # gsettings set org.gnome.system.proxy.http host '$PROXY_SERVER'
           # gsettings set org.gnome.system.proxy.http port $HTTP_PORT
        # fi
    # fi
elif [ -f /.dockerenv ]; then
    PROXY_SERVER=172.17.0.1
    HTTP_PORT=7890
    SOCKS_PORT=7891
    export https_proxy=http://$PROXY_SERVER:$HTTP_PORT http_proxy=http://$PROXY_SERVER:$HTTP_PORT all_proxy=socks5://$PROXY_SERVER:$SOCKS_PORT no_proxy=localhost,127.0.0.0/8,*.local,172.17.0.0/8
    export HTTPS_PROXY=http://$PROXY_SERVER:$HTTP_PORT HTTP_PROXY=http://$PROXY_SERVER:$HTTP_PORT ALL_PROXY=socks5://$PROXY_SERVER:$SOCKS_PORT NO_PROXY=localhost,127.0.0.0/8,*.local,172.17.0.0/8
 
fi

alias emacs='emacsclient -a "" -c'
alias e=emacs
alias s=screen
alias sl='screen -ls'
alias sr='screen -r'
alias pg=progress
alias py=python3
alias py2=python2.7
alias enw=emacs -nw
alias python=py
alias v=vi
alias vi=vim
alias vim='nvim'
which nvim &> /dev/null && alias vi='vim'
which exa &> /dev/null && alias ls='exa'
alias t='tmux'
alias ta='t attach -t'
alias td='t attach -d -t'
alias tl='t list-sessions'

#export VIM=/usr/local/share/nvim
#export VIMRUNTIME=/usr/local/share/nvim/runtime

export EDITOR=vi
if [ $PLATFORM = "Linux" ]; then
    alias pc='proxychains-ng -q'
fi

export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"


