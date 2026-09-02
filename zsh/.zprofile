# Homebrew. Apple Silicon only (see the macOS note in README).
eval "$(/opt/homebrew/bin/brew shellenv)"

# Python.org framework build, if one is installed.
for _pydir in /Library/Frameworks/Python.framework/Versions/*/bin(N); do
  path=("$_pydir" $path)
done
unset _pydir

# JetBrains Toolbox CLI launchers, if Toolbox is installed on this machine.
[[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]] && \
  path+=("$HOME/Library/Application Support/JetBrains/Toolbox/scripts")

# ~/.local/bin (pipx, personal scripts) is added in .zshrc; `typeset -U path`
# there collapses any duplicate, so it is deliberately not repeated here.
