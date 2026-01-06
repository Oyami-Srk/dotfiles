function rust-lint() {
    cargo fmt --all -- --check
    if [ $? -ne 0 ]; then
        return $?
    fi

    cargo clippy --all-features --all-targets --workspace --tests -- -D warnings
    return $?
}