# Necessary
export PATH=$PATH:$HOME/.config/ubin

# Optional
try_prepend_if_dir_exists "PATH" "$HOME/.local/bin"

try_prepend_if_dir_exists "PATH" "$HOME/.yarn/bin"
try_prepend_if_dir_exists "PATH" "$HOME/.config/yarn/global/node_modules/.bin"

try_prepend_if_dir_exists "PATH" "$HOME/.cargo/bin"
try_prepend_if_dir_exists "PATH" "$HOME/.platformio/penv/bin"

try_prepend_if_dir_exists "PATH" "/usr/local/opt/gettext/bin"
try_prepend_if_dir_exists "PATH" "/usr/local/opt/ncurses/bin"

try_prepend_if_dir_exists "PATH" "$HOME/.cargo/bin"
