# Necessary
export PATH=$PATH:$HOME/.config/ubin

# Optional
try_prepend_if_dir_exists "PATH" "$HOME/.local/bin"
try_prepend_if_dir_exists "PATH" "$HOME/.cargo/bin"
try_prepend_if_dir_exists "PATH" "$HOME/stapxx"
