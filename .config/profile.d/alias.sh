# Usage try_alias alias command
function try_alias() {
    local alias_expr=${@:-$#}
    if [[ 0 == "$alias_expr" ]]; then
        return 1
    fi
    local target=${alias_expr%=*}
    local to=${alias_expr#*=}
    if which ${to%% *} 1>/dev/null; then
        alias $target=$to
        return 0
    else
        return 2
    fi
}

function alias_linux() {
    alias open=xdg-open
    alias pc='proxychains -q'
    alias pbpaste='xclip -o sel'
    alias pbcopy='xclip -sel clip'
}

function alias_wsl() {
    alias pbcopy='clip.exe'
    alias pbpaste="powershell.exe Get-Clipboard | perl -pe 's/^\r\n$//g ; s/\r\n/\n/g;'"
    function wsl-open() {
        local rp="$(realpath $1)"
        if [[ $rp == /mnt/* ]]; then
            # Path is locate on windows volume
            local rp=$(sed "s/^.\{5\}//;s/\//\\\\/g;s/\(.\)/\1:/" <<<"$rp")
            explorer.exe $rp
        else
            # Path is locate on wsl volume
            local rp=$(sed "s/\//\\\\/g" <<<"$rp")
            explorer.exe "$WSL_ROOT_PATH$rp"
        fi
    }
    alias open="wsl-open"
}

function alias_common() {
    which thefuck &>/dev/null && eval $(thefuck --alias)
    which vim 1>/dev/null && alias vi=vim
    which nvim 1>/dev/null && alias vim=nvim
    which exa 1>/dev/null && alias ls=exa

    alias v=vi

    alias emacs='emacsclient -a "" -c'
    alias e=emacs
    alias enw=emacs -nw

    alias s=screen
    alias sl='screen -ls'
    alias sr='screen -r'

    alias pg=progress
    alias py=python3
    alias py2=python2.7
    alias python=py

    alias t='tmux'
    alias ta='t attach -t'
    alias td='t attach -d -t'
    alias tl='t list-sessions'

    alias minicom='env LANGUAGE=en LANG=en_US.UTF-8 minicom'
    alias hd="hexdump -ve '\"0x%08.8_ax  |  \" 4/1 \"%.2x \"   \"  \"4/1 \"%.2x \"   \"  \"4/1 \"%.2x \"   \"  \"4/1 \"%.2x \" ' -e '\" | \" 16/1 \"%_p\" \"\|\n\"'"

    alias r64objdump="riscv64-elf-objdump"
    alias r64objcopy="riscv64-elf-objcopy"
    alias r64gcc="riscv64-elf-gcc"
    alias r64ld="riscv64-elf-ld"
    alias r64g++="riscv64-elf-g++"
    alias r64gdb="riscv64-elf-gdb"

    alias pe='python-escpos'
    alias petxt='pe text --txt'
}

alias_common

if [ $SHELL_PLATFORM = "Linux" ]; then
    alias_linux
elif [ $SHELL_PLATFORM = "WSL1" ] || [ $SHELL_PLATFORM = "WSL2" ]; then
    alias_wsl
fi

unfunction alias_common
unfunction alias_linux
unfunction alias_wsl
