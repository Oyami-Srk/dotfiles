# Z-S-H Configruation file by Shrioko<hhx.xxm#gmail.com>
# Using zinit

_Z_DATA="$HOME/.config/.z"

if [[ ! -f "$_Z_DATA" ]]; then
    touch "$_Z_DATA"
fi

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_ALIAS_FINDER_AUTOMATIC=true

## History file configuration
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
[ "$HISTSIZE" -lt 5000000 ] && HISTSIZE=500000
[ "$SAVEHIST" -lt 1000000 ] && SAVEHIST=100000

ZINIT_DIR="${ZDOTDIR:-${HOME}}/.zinit"
ZINIT_SOURCE="${ZINIT_DIR}/bin/zinit.zsh"

# Load zinit
if [[ ! -f "$ZINIT_SOURCE" ]]; then
    echo "Zinit is missing. Installing it."

    [[ ! -d "$ZINIT_DIR" ]] && mkdir -p "$ZINIT_DIR" 2> /dev/null

    local repo_url="https://github.com/zdharma-continuum/zinit.git"

    if [[ ! -x "`which git`" ]]; then
        echo "WTF? Even git is missing..."
        exit 1
    fi

    git clone $repo_url "${ZINIT_DIR}/bin"

    if [[ $? != 0 ]]; then
        echo "Installation has failed, remove $ZINIT_DIR and try again..."
        exit
    else
        echo "Install completed~"
        echo "You can use envhelp restore to install packages backuped before."
        zcompile $ZINIT_SOURCE
    fi
fi

source $ZINIT_SOURCE

# zinit load plugins
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions
zinit ice lucid wait='0'
zinit light Tarrasch/zsh-bd
# MSYS2 need msys2-lua instead mingw64-lua
zinit ice lucid wait='0'
zinit light skywind3000/z.lua
zinit ice lucid wait='0'
zinit light arzzen/calc.plugin.zsh
zinit ice lucid wait='0'
zinit light hlissner/zsh-autopair
zinit ice lucid wait='0' as"null" atinit'fpath+=( $PWD );' atload"autoload -U deer;zle -N deer;bindkey '\ek' deer;"
zinit light Vifon/deer

zinit ice wait lucid
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/git.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::lib/key-bindings.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/compfix.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/directories.zsh
zinit ice wait lucid
zinit snippet OMZ::lib/grep.zsh
zinit snippet OMZ::lib/functions.zsh
zinit snippet OMZ::lib/misc.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh
zinit ice wait lucid atload"unalias grv"
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/pip/pip.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/github/github.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/python/python.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/colorize/colorize.plugin.zsh
zinit ice wait lucid
zinit snippet OMZ::plugins/alias-finder/alias-finder.plugin.zsh

# zinit ice wait lucid from'gh-r' as'program'
# zinit light sei40kr/fast-alias-tips-bin
# zinit ice wait lucid
# zinit light sei40kr/zsh-fast-alias-tips

# Theme
if which disable_starship &> /dev/null; then
    eval $(starship init zsh)
else
    setopt promptsubst
    setopt prompt_subst
    local ret_status="%F{blue}[%s%?]"
    PS1='%F{green}%2c%F{blue} >  %f'
    RPROMPT='$(git_prompt_info) %F{green}%D{%H:%M:%S} $ret_status'
    if [ $SHELL_PLATFORM = "MSYS" ]; then
        # git prompt info is too slow on msys2
        RPROMPT='%F{green}%D{%H:%M:%S} $ret_status'
    fi

    ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
    ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
    ZSH_THEME_GIT_PROMPT_CLEAN=""
fi

# zsh config
setopt APPEND_HISTORY
setopt hist_ignore_space

# default keymap
bindkey '\eh' backward-char
bindkey '\el' forward-char
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history

bindkey '\eH' backward-word
bindkey '\eL' forward-word
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line

bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'

# Turn off case-sensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

KEYTIMEOUT=1
export TERM=xterm-256color

unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

autoload -U +X compinit && compinit
#compdef pio
_pio() {
  eval $(env COMMANDLINE="${words[1,$CURRENT]}" _PIO_COMPLETE=complete-zsh  pio)
}
if [[ "$(basename -- ${(%):-%x})" != "_pio" ]]; then
  compdef _pio pio
fi

[[ ! -z "${ZPROF}" ]] && zprof
