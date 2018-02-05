# Z-S-H Configruation file by Shrioko<hhx.xxm#gmail.com>

if [[ -o login ]]; then
	[ -f "$HOME/.config/login.sh" ] && sh "$HOME/.config/login.sh"
fi

ZGEN_PATH="$HOME/.config/zsh"
ZGEN_SOURCE="${ZGEN_PATH}/zgen/zgen.zsh"

if [[ ! -f "$ZGEN_SOURCE" ]]; then
    echo "Zgen is missing... Install it!!!"

    [[ ! -d "$ZGEN_PATH" ]] && mkdir -p "$ZGEN_PATH" 2> /dev/null

    repo_url="https://github.com/tarjoilija/zgen.git"

    if [[ ! -x "`which git`" ]]; then
        echo "WTF? Even git is missing..."
        exit
    fi

    git clone https://github.com/tarjoilija/zgen.git "${ZGEN_PATH}/zgen"

    if [[ $? != 0 ]]; then
        echo "Installation has failed, remove $ZGEN_PATH and try again..."
        exit
    else
        echo "Install completed~"
    fi
fi

# Load zgen
source $ZGEN_SOURCE

# if init script doesnt exist.
if ! zgen saved; then
    # Load base framework
    zgen oh-my-zsh
    # Load plugins
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/pip
    zgen oh-my-zsh plugins/github
    zgen oh-my-zsh plugins/python
    zgen oh-my-zsh plugins/colorize
    zgen oh-my-zsh plugins/sudo

    # Load packages
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    zgen load zsh-users/zsh-completions src
    zgen load Vifon/deer
    zgen load Tarrasch/zsh-bd


    # Save init script
    zgen save
fi


# syntax color definition
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_STYLES

# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'

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

# Theme
local ret_status="%F{blue}[%s%?]"
PROMPT='%F{green}%2c%F{blue} λ%f '
RPROMPT='$(git_prompt_info) %F{green}%D{%H:%M:%S} $ret_status'

ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# KeyBinds & Setup
autoload -U deer
zle -N deer

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

# ignore complition
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
