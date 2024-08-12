if [ $SHELL_PLATFORM != "Darwin" ]; then
    return
fi

# Homebrew tuna mirror setup
export HOMEBREW_API_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api"
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"

# Homebrew shell setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew llvm binary path setup
export PATH="$(brew --prefix)/opt/llvm/bin:$PATH"
