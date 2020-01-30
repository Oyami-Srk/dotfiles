export PLATFORM="$(uname 2> /dev/null)"

export GOROOT=/usr/local/opt/go/libexec
# GOPAT为上面创建的目录路径
export GOPATH=$HOME/Projects/golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PATH=$PATH:$HOME/.config/ubin

export SSH_KEY_PATH="~/.ssh/id_rsa"

if [ $PLATFORM = "Darwin" ]; then
    # homebrew
    export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
    export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7891
fi

alias emacs='emacsclient -a "" -c'
alias e=emacs
alias s=screen
alias sl='screen -ls'
alias sr='screen -r'
alias pg=progress
alias pc='proxychains4 -q'
alias py=python3
alias py2=python2.7
alias enw=emacs -nw
alias python=py
alias vim='nvim'
alias vi='nvim'
alias pe='python-escpos'
alias petxt='pe text --txt'

#export VIM=/usr/local/share/nvim
#export VIMRUNTIME=/usr/local/share/nvim/runtime

export EDITOR=nvim
if [ $PLATFORM = "Linux" ]; then
    export TERMINAL=termite
    alias pc='proxychains-ng -q'
fi

