if [ $SHELL_PLATFORM != "Darwin" ]; then
    return
fi

# Homebrew shell setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew llvm binary path setup
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
