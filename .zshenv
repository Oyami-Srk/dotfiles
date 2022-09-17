PLATFORM="$(uname 2>/dev/null)"
[[ "$PLATFORM" == *NT* ]] && PLATFORM="MSYS"
if [ $PLATFORM = "Linux" ] || [ ! -z ${WSL_DISTRO_NAME} ]; then
    local WSL2_Flag="$(cat /proc/interrupts )"
    if [[ $WSL2_Flag ]] ; then
        PLATFORM="WSL2"
    else
        PLATFORM="WSL1"
    fi
fi
export PLATFORM
if [ $PLATFORM = "Darwin" ]; then
elif [ $PLATFORM = "Linux" ]; then
elif [ $PLATFORM = "WSL1" ]; then
elif [ $PLATFORM = "WSL2" ]; then
elif [ $PLATFORM = "MSYS" ]; then
else
    echo "Your platform ${PLATFORM} is not inside one of my collects."
fi

export PATH=$PATH:$HOME/.config/ubin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

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
HTTP_PORT=7890
SOCKS_PORT=7890
if sh -c 'LANG=C ss -lntu | grep LISTEN.*7890' &>/dev/null; then
    PROXY_SERVER="127.0.0.1"
elif [ -f /.dockerenv ]; then
    PROXY_SERVER="172.17.0.1"
elif [[ $PLATFORM == "WSL2" && -f /etc/resolv.conf ]]; then
    PROXY_SERVER=$(sed -n "s/^nameserver\s\(.*\)$/\1/p" /etc/resolv.conf)
else
    PROXY_SERVER="127.0.0.1"
fi
export https_proxy=http://$PROXY_SERVER:$HTTP_PORT http_proxy=http://$PROXY_SERVER:$HTTP_PORT all_proxy=socks5://$PROXY_SERVER:$SOCKS_PORT no_proxy=localhost,127.0.0.0/8,*.local
export HTTPS_PROXY=http://$PROXY_SERVER:$HTTP_PORT HTTP_PROXY=http://$PROXY_SERVER:$HTTP_PORT ALL_PROXY=socks5://$PROXY_SERVER:$SOCKS_PORT NO_PROXY=localhost,127.0.0.0/8,*.local

[[ -f $(which nvim) ]] && export EDITOR=nvim
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"
export PATH=$PATH:$HOME/.platformio/penv/bin

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

if [ $PLATFORM = "Darwin" ]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools
    export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"
elif [ $PLATFORM = "Linux" ]; then
    alias open=xdg-open
elif [ $PLATFORM = "MSYS" ]; then
    export ZLUA_EXEC="/msys2-lua.exe"
    function msys2-open() {
    	if [[ -f "$1" ]]; then
	    powershell.exe -c start "$1"
        else
	    explorer.exe $(echo "$1" | sed "s/\//\\\\/g")
	fi
    }
    alias open="msys2-open"
elif [ $PLATFORM = "WSL1" ] || [ $PLATFORM = "WSL2" ]; then
    function wsl-open() {
        if [[ -f "$1" ]]; then
	    powershell.exe -c start "$1"
	else
	    explorer.exe "$1"
	fi
    }
    alias open="wsl-open"
fi

