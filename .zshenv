export PLATFORM="$(uname 2> /dev/null)"

export GOROOT=/usr/local/opt/go/libexec
# GOPAT为上面创建的目录路径
export GOPATH=$HOME/Projects/golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.config/ubin

export SSH_KEY_PATH="~/.ssh/id_rsa"

if [ $PLATFORM = "Darwin" ]; then
    # pipx
    export PATH="$PATH:/Users/shiroko/Library/Python/3.7/bin"
    # homebrew
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    if [ $TERM_PROGRAM = "iTerm.app" ]; then
        export PATH="$PATH:$HOME/.config/ubin/macos"
    fi

    alias pe='python-escpos'
    alias petxt='pe text --txt'
    alias pc='proxychains4 -q'
fi

# Check whether clash is start and export proxy env
if sh -c 'LANG=C netstat -an | grep "\(\.\|\:\)7890.*LISTEN"' &> /dev/null; then
    export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
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

