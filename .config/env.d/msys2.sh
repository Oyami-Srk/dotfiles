if [ $SHELL_PLATFORM != "MSYS" ]; then
    return
fi

export ZLUA_EXEC="/msys2-lua.exe"
function msys2-open() {
    if [[ -f "$1" ]]; then
        powershell.exe -c start "$1"
    else
        explorer.exe $(echo "$1" | sed "s/\//\\\\/g")
    fi
}
alias open="msys2-open"
alias pbcopy='clip.exe'
alias pbpaste="powershell.exe Get-Clipboard | perl -pe 's/^\r\n$//g ; s/\r\n/\n/g;'"
