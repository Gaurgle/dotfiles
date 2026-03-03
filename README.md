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
| ghostty | `~/.config/ghostty/config` |
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

## Modifier key philosophy

| Key | Role |
|-----|------|
| Caps Lock | Hyper key (Ctrl+Shift+Alt+Cmd) via Karabiner — tap for Escape |
| Ctrl | tmux prefix (`C-a`) |
| Cmd | macOS standard shortcuts |
| Option (Alt) | AeroSpace window manager |

## Keybindings

### Karabiner

- **Caps Lock** (hold) → Hyper key (Ctrl+Shift+Alt+Cmd) — used for app launching and global shortcuts
- **Caps Lock** (tap) → Escape
- External keyboard: grave/tilde and non-US backslash are swapped (ANSI layout fix)

### AeroSpace (tiling window manager)

All bindings use **Option (Alt)** as the modifier.

**Focus & move (vim-style):**

| Bind | Action |
|------|--------|
| `opt+h/j/k/l` | Focus left/down/up/right |
| `opt+shift+h/j/k/l` | Move window left/down/up/right |
| `opt+cmd+h/j/k/l` | Join window into container |

**Workspaces:**

| Bind | Action |
|------|--------|
| `opt+1-9` | Switch to numbered workspace |
| `opt+b` | Workspace b (main project) |
| `opt+e` | Workspace e (email) |
| `opt+m` | Workspace m (messages) |
| `opt+c` | Workspace c (calendar) |
| `opt+s` | Workspace s (Slack/Discord) |
| `opt+z` | Workspace z (secondary project) |
| `opt+shift+<key>` | Move window to that workspace |
| `opt+tab` | Toggle previous workspace |
| `opt+shift+tab` | Move workspace to next monitor |

**Window management:**

| Bind | Action |
|------|--------|
| `opt+f` | Fullscreen |
| `opt+w` | Close window |
| `opt+enter` | New WezTerm terminal |
| `opt+/` | Toggle tile horizontal/vertical |
| `opt+,` | Toggle accordion mode |
| `opt+-/=` | Resize shrink/grow |

**Modes:**

| Bind | Action |
|------|--------|
| `opt+a` | **Apps mode** — then: `m` Messages, `w` WhatsApp, `s` Slack, `t` Telegram, `d` Discord, `c` Calendar |
| `opt+shift+;` | **Service mode** — then: `r` reset layout, `f` toggle float, `up/down` volume |

### tmux

Prefix: **Ctrl+a** (Ctrl+b also works as secondary)

| Bind | Action |
|------|--------|
| `C-h/j/k/l` | Navigate panes (vim-tmux-navigator, works in nvim too) |
| `prefix+I` | Install plugins via tpm |
| `prefix+r` | Reload config |
| Mouse | Enabled for pane selection and scrolling |

**Plugins:** sensible, vim-tmux-navigator, resurrect, yank, fzf, battery, cpu, online-status, catppuccin (macchiato)

### Ghostty

| Bind | Action |
|------|--------|
| `cmd+1-9` | Switch to tab |
| `cmd+shift+d` | Split pane down |
| `cmd+shift+9/8` | Move tab forward/back |
| `opt+backspace` | Delete word |

Theme: Catppuccin Mocha, font: JetBrainsMono Nerd Font 13pt

### IdeaVim (IntelliJ / Android Studio)

Plugins: vim-highlightedyank, vim-commentary, nerdtree

| Bind | Action |
|------|--------|
| `C-h` | Open project explorer |
| `C-l` | Focus editor |
| `l` (in NERDTree) | Activate/open node |
| `h` (in NERDTree) | Jump to parent |
| `Q` | Format selection (gq) |

### IntelliJ custom keymap ("macOS copy")

Based on Mac OS X 10.5+ with these overrides:

**Hyper key (Caps Lock) shortcuts:**

| Bind | Action |
|------|--------|
| `hyper+0` | AI Assistant tool window |
| `hyper+6` | Gradle tool window |
| `hyper+7` | Maven tool window |
| `hyper+8` | Database tool window |
| `hyper+9` | Version Control tool window |
| `hyper++` | Run tool window |
| `hyper+j j` | AI inline editor |
| `hyper+w` | Line comment |
| `hyper+backtick` | Terminal |

**Cmd shortcuts:**

| Bind | Action |
|------|--------|
| `cmd+l` | Reformat code |
| `cmd+shift+w` | Block comment |
| `cmd+shift+n` | New class |
| `cmd+shift+p` | New directory |
| `cmd+shift+alt+n` | New scratch file |
| `cmd+[/]` | Navigate back/forward |
| `cmd+alt+up/down` | Code block start/end |
| `cmd+up/down` | Page top/bottom |
| `ctrl+,/.` | Decrease/increase font size |

### Shell (zsh)

**Aliases:**

| Alias | Command |
|-------|---------|
| `lz` | `eza --icons --group-directories-first --grid` |
| `gitconf` | View `.gitconfig` with syntax highlighting |

**Git aliases (in .gitconfig):**

| Alias | Command |
|-------|---------|
| `git st` | `status` |
| `git a` | `add .` |
| `git cm "msg"` | `commit -m "msg"` |
| `git gac "msg"` | `add . && commit -m "msg"` |
| `git amend` | `commit --amend --no-edit` |
| `git lg` | Pretty log graph |
| `git p` | `push` |
| `git pl` | `pull` |
| `git co` | `checkout` |
| `git nb` | `checkout -b` (new branch) |
| `git pnb` | Push and set upstream for current branch |
| `git unstage` | `reset HEAD --` |
| `git last` | Show last commit |
| `git week` | Weekly log with dates |

**Tools:**
- **zoxide** with pwd hook — `z <fuzzy>` to jump to frequently used dirs, learns from `cd`
- **oh-my-posh** with zen theme for prompt
- **zsh-autosuggestions** and **zsh-syntax-highlighting**
- **eza** as `ls` replacement (via `lz` alias)

## How stow works

Files live in this repo and are symlinked to `~` via `stow`. Edits to configs are automatically tracked by git.

```bash
stow nvim        # Create symlinks for nvim
stow -D nvim     # Remove symlinks (unstow)
stow -R nvim     # Refresh symlinks (restow)
```
