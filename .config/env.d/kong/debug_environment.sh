# Disable anno reports globally
update_export KONG_ANONYMOUS_REPORTS=off

# Disable Kong from use system cargo
update_export KONG_TEST_USER_CARGO_DISABLED=1

# Set default KONG_NGINX_WORKER_PROCESSES
# update_export DEFAULT_KONG_NGINX_WORKER_PROCESSES=1
