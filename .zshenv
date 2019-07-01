export GOROOT=/usr/local/opt/go/libexec
# GOPAT为上面创建的目录路径
export GOPATH=/Users/shiroko/Projects/golang
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

export SSH_KEY_PATH="~/.ssh/id_rsa"
export PATH="/Users/shiroko/node_modules/tern/bin/:$PATH"

# homebrew
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

alias emacs='emacsclient -a "" -c'
alias e=emacs
alias s=screen
alias sl='screen -ls'
alias sr='screen -r'
alias pg=progress
alias pc='proxychains -q'
alias py=python3
alias py2=python2.7
alias enw=emacs -nw
alias python=py
alias vim='nvim'
alias vi='nvim'

#export VIM=/usr/local/share/nvim
#export VIMRUNTIME=/usr/local/share/nvim/runtime

export EDITOR=nvim
if [ "$(uname 2> /dev/null)" = "Linux" ]; then
    export TERMINAL=termite
fi
