# Rust toolchain. Guarded: a machine without rustup has no ~/.cargo/env, and an
# unguarded `.` here errors on every single zsh invocation, interactive or not.
if [[ -r "$HOME/.cargo/env" ]]; then
  . "$HOME/.cargo/env"
fi
