# Z-S-H Configruation file by Shrioko<hhx.xxm#gmail.com>

# Var Defines
ANTIGEN="$HOME/.local/bin/antigen.zsh"


if [[ $TERM_PROGRAM == "iTerm.app" ]]; then
    bindkey    "^[[3~"          delete-char
    bindkey    "^[3;5~"         delete-char
fi

if [[ ! -f "$ANTIGEN" ]]; then
    echo "Antigen wat not found... Install it!"

    [[ ! -d "$HOME/.local" ]] && mkdir -p "$HOME/.local" 2> /dev/null
    [[ ! -d "$HOME/.local/bin" ]] && mkdir -p "$HOME/.local/bin" 2> /dev/null
    [[ ! -f "$HOME/.z" ]] && touch "$HOME/.z"

    URL="http://git.io/antigen"
    TMPFILE="/tmp/antigen.zsh"

    if [[ -x "`which curl`" ]]; then
        curl -L "$URL" -o "$TMPFILE" -s
    elif [[ -x "`which wget`" ]]; then
        wget "$URL" -o "$TMPFILE"
    else
        echo "Emmmm...Both curl and wget are missing, what are you using??"
        exit
    fi

    [[ ! $? == 0 ]] && echo "Download failed desu!!!" && exit

    mv "$TMPFILE" "$ANTIGEN"
    [[ $? == 0 ]] && echo "Install completed~"
fi

# Output prompt

autoload -U colors && colors

host_name="%{$fg[cyan]%}萌"
path_string="%{$fg[yellow]%}%~"
prompt_string="$"

# Make prompt_string red if the previous command failed.
local return_status="%(?:%{$fg[blue]%}$prompt_string:%{$fg[red]%}$prompt_string)"


_git_branch_name() {
    git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}
_git_is_dirty() {
    git diff --quiet 2> /dev/null || echo '*'
}

setopt prompt_subst 
RPROMPT='$(_git_branch_name) $(_git_is_dirty)'

# Initialize antigen
source "$ANTIGEN"


# Initialize oh-my-zsh
antigen use oh-my-zsh


PROMPT="${host_name} ${path_string} ${return_status} %{$reset_color%}"

# default bundles
# visit https://github.com/unixorn/awesome-zsh-plugins
# antigen bundle git
# antigen bundle heroku
antigen bundle pip
antigen bundle svn-fast-info
# antigen bundle command-not-find

antigen bundle colorize
antigen bundle github
antigen bundle python
antigen bundle rupa/z z.sh
# antigen bundle z

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
# antigen bundle supercrabtree/k
antigen bundle Vifon/deer

# uncomment the line below to enable theme
# antigen theme fishy


# check login shell
if [[ -o login ]]; then
	[ -f "$HOME/.local/etc/login.sh" ] && source "$HOME/.local/etc/login.sh"
	[ -f "$HOME/.local/etc/login.zsh" ] && source "$HOME/.local/etc/login.zsh"
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

# load local config
[ -f "$HOME/.local/etc/config.zsh" ] && source "$HOME/.local/etc/config.zsh" 
[ -f "$HOME/.local/etc/local.zsh" ] && source "$HOME/.local/etc/local.zsh"

# enable syntax highlighting
antigen bundle zsh-users/zsh-syntax-highlighting

antigen apply

# setup for deer
autoload -U deer
zle -N deer

PROMPT="${host_name} ${path_string} ${return_status} %{$reset_color%}"
# default keymap
bindkey -s '\ee' 'vim\n'
bindkey '\eh' backward-char
bindkey '\el' forward-char
bindkey '\ej' down-line-or-history
bindkey '\ek' up-line-or-history
# bindkey '\eu' undo
bindkey '\eH' backward-word
bindkey '\eL' forward-word
bindkey '\eJ' beginning-of-line
bindkey '\eK' end-of-line

bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3A' beginning-of-line
bindkey '\e[1;3B' end-of-line

bindkey '\ev' deer

alias ll='ls -l'


# source function.sh if it exists
[ -f "$HOME/.local/etc/function.sh" ] && . "$HOME/.local/etc/function.sh"


# ignore complition
zstyle ':completion:*:complete:-command-:*:*' ignored-patterns '*.pdf|*.exe|*.dll'
