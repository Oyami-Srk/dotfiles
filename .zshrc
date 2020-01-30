# Z-S-H Configruation file by Shrioko<hhx.xxm#gmail.com>
export LC_CTYPE=en_US.UTF-8

if [[ -o login ]]; then
	[ -f "$HOME/.config/login.sh" ] && sh "$HOME/.config/login.sh"
fi

ZGEN_PATH="$HOME/.config/zsh"
ZGEN_SOURCE="${ZGEN_PATH}/zgen/zgen.zsh"

# syntax color definition
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
ZSH_HIGHLIGHT_STYLES[default]=none
ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[commandseparator]=none
ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
ZSH_HIGHLIGHT_STYLES[assign]=none

ZSH_AUTOSUGGEST_USE_ASYNC=true
ZSH_ALIAS_FINDER_AUTOMATIC=true

export _ZL_DATA="$HOME/.config/.z"

if [[ ! -f "$_ZL_DATA" ]]; then
    touch "$_ZL_DATA"
fi

# Load zgen
if [[ ! -f "$ZGEN_SOURCE" ]]; then
    echo "Zgen is missing... Install it!!!"

    [[ ! -d "$ZGEN_PATH" ]] && mkdir -p "$ZGEN_PATH" 2> /dev/null

    repo_url="https://github.com/tarjoilija/zgen.git"

    if [[ ! -x "`which git`" ]]; then
        echo "WTF? Even git is missing..."
        exit 1
    fi

    git clone https://github.com/tarjoilija/zgen.git "${ZGEN_PATH}/zgen"
    zcompile $ZGEN_SOURCE

    if [[ $? != 0 ]]; then
        echo "Installation has failed, remove $ZGEN_PATH and try again..."
        exit
    else
        echo "Install completed~"
        echo "You can use envhelp restore to install packages backuped before."
    fi
fi

# if init script doesnt exist.
if [[ ! -s ${ZDOTDIR:-${HOME}}/.zgen/init.zsh ]]; then

    source $ZGEN_SOURCE
    # Load base framework
    zgen oh-my-zsh
    # Load plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/colorize
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/alias-finder
    if [[ $OSTYPE =~ "darwin" ]]; then
        zgen oh-my-zsh plugins/osx
        zgen load laggardkernel/zsh-iterm2
    fi

    # Load packages
    # zgen load zsh-users/zsh-syntax-highlighting
    zgen load zdharma/fast-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions src
    zgen load Vifon/deer
    zgen load Tarrasch/zsh-bd
    # zgen load rupa/z z.sh
    zgen load skywind3000/z.lua
    zgen load arzzen/calc.plugin.zsh
    zgen load hlissner/zsh-autopair

    # Save init script
    zgen save
    zcompile ${ZDOTDIR:-${HOME}}/.zgen/init.zsh
else
  source ${ZDOTDIR:-${HOME}}/.zgen/init.zsh
  # source $ZGEN_SOURCE
fi

# Load zgen only if a user types a zgen command
zgen () {
	source $ZGEN_SOURCE
	zgen "$@"
}

zgen-pure () {
    rm -f ${ZDOTDIR:-${HOME}}/.zgen/init.zsh
}

# Theme
local ret_status="%F{blue}[%s%?]"
PROMPT='%F{green}%2c%F{blue} >  %f'
RPROMPT='$(git_prompt_info) %F{green}%D{%H:%M:%S} $ret_status'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# KeyBinds & Setup
autoload -U deer
zle -N deer

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

bindkey '\ev' deer
bindkey '\ec' autosuggest-clear

# alias
alias ll='ls -l'

# Turn off case-sensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

export PATH="/usr/local/opt/gettext/bin:$PATH"
export PATH="/usr/local/opt/ncurses/bin:$PATH"

KEYTIMEOUT=1
export TERM=xterm-256color
