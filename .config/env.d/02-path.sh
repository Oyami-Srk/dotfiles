# Necessary
export PATH=$PATH:$HOME/.config/ubin
export PATH=$PATH:/usr/local/bin

# Optional
try_prepend_if_dir_exists "PATH" "$HOME/.local/bin"
try_prepend_if_dir_exists "PATH" "$HOME/.cargo/bin"
try_prepend_if_dir_exists "PATH" "$HOME/.luarocks/bin"
try_prepend_if_dir_exists "PATH" "$HOME/stapxx"
