# Disable anno reports globally
update_export KONG_ANONYMOUS_REPORTS=off

# Disable Kong from use system cargo
update_export KONG_TEST_USER_CARGO_DISABLED=1

# Set default KONG_NGINX_WORKER_PROCESSES
# update_export DEFAULT_KONG_NGINX_WORKER_PROCESSES=1

if [ -d "$ZSH_ENV_OPT_DIAG_UTILS"/bin ]; then
    try_append_if_dir_exists PATH "$HOME/diag-utils/bin"
fi

export STAPXX_PATH="$ZSH_ENV_OPT_DIAG_UTILS/stapxx"
export OR_DEV_UTILS_PATH="$ZSH_ENV_OPT_DIAG_UTILS/openresty-devel-utils"
