if [ $SHELL_PLATFORM != "Darwin" ]; then
    return
fi

# lib
export LIBRARY_PATH="$LIBRARY_PATH:/usr/local/lib"
# pipx
export PATH="$PATH:$HOME/Library/Python/3.7/bin"
# homebrew
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles
export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/bottles
try_prepend_if_dir_exists PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
try_prepend_if_dir_exists PATH "/Applications/goneovim.app/Contents/MacOS"
if [ "x$TERM_PROGRAM" = "xiTerm.app" ]; then
    export PATH="$PATH:$HOME/.config/ubin/macos"
fi

if [ -d "$HOME/Library/Android/sdk" ]; then
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export PATH=$PATH:$ANDROID_HOME/emulator
    export PATH=$PATH:$ANDROID_HOME/tools
    export PATH=$PATH:$ANDROID_HOME/tools/bin
    export PATH=$PATH:$ANDROID_HOME/platform-tools
fi

try_prepend_if_dir_exists PATH "/usr/local/opt/make/libexec/gnubin"
try_prepend_if_dir_exists "PATH" "/Library/TeX/texbin"

alias pc='proxychains4 -q'
