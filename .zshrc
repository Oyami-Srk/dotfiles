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
zinit ice lucid wait atinit='zpcompinit'
zinit light zdharma-continuum/fast-syntax-highlighting
zinit ice lucid wait atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions
zinit ice lucid wait
zinit light zsh-users/zsh-completions
zinit ice lucid wait
zinit light Tarrasch/zsh-bd
# MSYS2 need msys2-lua instead mingw64-lua
# zinit ice lucid wait
# zinit light skywind3000/z.lua
zinit ice lucid wait
zinit light arzzen/calc.plugin.zsh
zinit ice lucid wait
zinit light hlissner/zsh-autopair
zinit ice lucid wait as"null" atinit'fpath+=( $PWD );' atload"autoload -U deer;zle -N deer;bindkey '\ek' deer;"
zinit light Vifon/deer
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode
zinit ice lucid wait atload"bindkey -M vicmd ' ' vi-easy-motion"
zinit light IngoMeyer441/zsh-easy-motion

zinit snippet OMZ::lib/async_prompt.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/functions.zsh
zinit snippet OMZ::lib/misc.zsh
zinit snippet OMZ::lib/key-bindings.zsh

zinit ice lucid wait
zinit snippet OMZ::lib/completion.zsh
zinit ice lucid wait
zinit snippet OMZ::lib/history.zsh
zinit ice lucid wait
zinit snippet OMZ::lib/compfix.zsh
zinit ice lucid wait
zinit snippet OMZ::lib/directories.zsh
zinit ice lucid wait
zinit snippet OMZ::lib/grep.zsh
zinit ice lucid wait
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit ice lucid wait atload"unalias grv"
zinit snippet OMZ::plugins/git/git.plugin.zsh
zinit ice lucid wait
zinit snippet OMZ::plugins/pip/pip.plugin.zsh
zinit ice lucid wait
zinit snippet OMZ::plugins/github/github.plugin.zsh
zinit ice lucid wait
zinit snippet OMZ::plugins/python/python.plugin.zsh
zinit ice lucid wait
zinit snippet OMZ::plugins/colorize/colorize.plugin.zsh
zinit ice lucid wait
zinit snippet OMZ::plugins/alias-finder/alias-finder.plugin.zsh
# zinit ice wait lucid
# zinit snippet OMZ::plugins/dotenv/dotenv.plugin.zsh

# zinit ice lucid wait from'gh-r' as'program'
# zinit light sei40kr/fast-alias-tips-bin
# zinit ice lucid wait
# zinit light sei40kr/zsh-fast-alias-tips
zinit ice lucid wait from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice lucid wait as"program" from"gh-r" mv"mise* -> mise" \
    atclone"\$(pwd)/mise activate zsh > init.zsh"  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light jdx/mise

zinit ice lucid wait as"program" from"gh-r" \
    atclone"./zoxide init zsh > init.zsh"  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

zinit ice lucid wait
zinit light Oyami-Srk/zsh-dotenv

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

# migrating to vim mode, with alt+delete as delete world
bindkey -M viins '^[^H' backward-delete-word
# For Windows Terminal
bindkey -M viins '^[^?' backward-delete-word


# Turn off case-sensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey "^[OA" history-beginning-search-backward
bindkey "^[OB" history-beginning-search-forward

KEYTIMEOUT=1
export TERM=xterm-256color

unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1

[[ ! -z "${ZPROF}" ]] && zprof

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true
