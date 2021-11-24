export PLATFORM="$(uname 2> /dev/null)"

# export GOROOT=/usr/local/opt/go/libexec
# GOPAT为上面创建的目录路径
# export GOPATH=$HOME/Projects/golang
# export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.config/ubin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

export SSH_KEY_PATH="~/.ssh/id_rsa"

if [ $PLATFORM = "Darwin" ]; then
    # lib
    export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"
    # pipx
    export PATH="$PATH:$HOME/Library/Python/3.7/bin"
    # homebrew
    # export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export PATH="$PATH:/Applications/goneovim.app/Contents/MacOS"
    if [ "x$TERM_PROGRAM" = "xiTerm.app" ]; then
        export PATH="$PATH:$HOME/.config/ubin/macos"
    fi
fi

# Check whether clash is start and export proxy env
if sh -c 'LANG=C ss -lntu | grep LISTEN.*7890' &> /dev/null; then
    PROXY_SERVER=127.0.0.1
    HTTP_PORT=7890
    SOCKS_PORT=7890
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

#export VIM=/usr/local/share/nvim
#export VIMRUNTIME=/usr/local/share/nvim/runtime

export EDITOR=nvim
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH=$PATH:~/.platformio/penv/bin

source "$HOME/.cargo/env"
. "$HOME/.cargo/env"

if [ $PLATFORM = "Darwin" ]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
fi
if [ $PLATFORM = "Linux" ]; then
    alias open=xdg-open
fi
export PATH=$PATH:$ANDROID_HOME/platform-tools
