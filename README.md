# dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/) and [Homebrew Bundle](https://github.com/Homebrew/homebrew-bundle).

## Setup on a new Mac

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Clone
git clone https://github.com/Gaurgle/dotfiles ~/.dotfiles
cd ~/.dotfiles

# Install all packages
brew bundle

# Symlink all configs
stow aerospace tmux zsh git nvim karabiner ghostty kitty starship yazi btop zellij zed zen-omp gh ideavim

# Install tmux plugins (open tmux, then prefix + I)
```

## Stow packages

| Package | Config location |
|---------|----------------|
| aerospace | `~/.config/aerospace/aerospace.toml` |
| btop | `~/.config/btop/` |
| gh | `~/.config/gh/` |
| ghostty | `~/.config/ghostty/` |
| git | `~/.gitconfig`, `~/.config/git/ignore` |
| ideavim | `~/.ideavimrc` |
| karabiner | `~/.config/karabiner/` |
| kitty | `~/.config/kitty/` |
| nvim | `~/.config/nvim/` |
| starship | `~/.config/starship/` |
| tmux | `~/.tmux.conf`, `~/.tmux/plugins/tpm` |
| yazi | `~/.config/yazi/` |
| zed | `~/.config/zed/` |
| zellij | `~/.config/zellij/` |
| zen-omp | `~/.config/zen-omp.toml` |
| zsh | `~/.zshrc`, `~/.zshenv`, `~/.zprofile` |

## How it works

Files live in this repo and are symlinked to `~` via `stow`. Edits to your configs are automatically tracked by git.

To stow a single package: `stow nvim`

To unstow: `stow -D nvim`

To restow (refresh symlinks): `stow -R nvim`
