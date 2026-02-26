# dotfiles

## Structure

```
dotfiles/
├── git/
│   └── .gitconfig
├── zsh/
│   ├── .zshrc
│   └── .zshenv
├── vim/
│   └── .vimrc
├── tmux/
│   └── .tmux.conf
├── homebrew/
│   └── Brewfile
├── macos/
│   └── defaults.sh       # macOS settings
├── install.sh             # Bootstrap script
├── Makefile               # Alternative to install.sh
└── README.md
```

## Key principles

**1. Automated installation**
A single command (`make install` or `./install.sh`) that sets up everything — symlinks, packages, shell config.

**2. Symlinks instead of copying**
Files live in the repo and are symlinked to `~`. Changes are automatically tracked by git. Tools like `stow` or a custom script handle this.

**3. Modular layout**
Each tool in its own folder. Easy to add/remove parts without affecting the rest.

**4. Brewfile / package list**
Declarative list of everything to install:
```ruby
# Brewfile
brew "git"
brew "fzf"
brew "ripgrep"
cask "wezterm"
```

**5. Idempotent**
The script should be safe to run multiple times — it only creates what's missing.

**6. Secrets stay out**
API keys, tokens etc. should **never** be committed. Use `.gitignore` or separate files that are sourced locally.

## Useful tools

| Tool | Purpose |
|------|---------|
| **GNU Stow** | Symlink management |
| **chezmoi** | Dotfiles manager with templates and secrets |
| **yadm** | Git wrapper specifically for dotfiles |
| **Homebrew Bundle** | Package management via Brewfile |
| **Nix / home-manager** | Declarative system configuration |

## Tips

- **Start small** — only add what you actually use
- **Document** — a short README explaining how to get started
- **Test on a clean machine** (or in a container) to verify bootstrap works
- **Tag/branch** if you want to support multiple machines (work vs personal)
