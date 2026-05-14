# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# --- Terminal output capture (manual paste) ---
export __ZSH_LAST_OUTPUT=""

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(zoxide init zsh --hook pwd)"

# Aliases
alias gitconf="bat ~/.gitconfig --language ini"
alias gitconfig="bat ~/.gitconfig --language ini"
lz() {
  local count
  count=$(eza --icons --group-directories-first "$@" 2>/dev/null | wc -l | tr -d ' ')
  if (( count <= 8 )); then
    eza --icons --group-directories-first --long "$@"
  else
    eza --icons --group-directories-first --grid "$@"
  fi
}
alias lz.='lz --all'
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first --long"
alias la="eza --icons --group-directories-first --long --all"
alias tree="eza --icons --tree"
alias cat="bat"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ..l='cd .. && eza -la'
alias ...l='cd ../.. && eza -la'
alias cpwd="pwd | pbcopy"
fcount() {
  if [[ -z "$1" ]]; then
    echo "files: $(find . -type f | wc -l | tr -d ' ')"
    echo "dirs:  $(find . -type d | wc -l | tr -d ' ')"
  elif [[ "$1" == "dir" || "$1" == "dirs" || "$1" == "directories" ]]; then
    echo "dirs:    $(find . -maxdepth 1 -type d | tail -n +2 | wc -l | tr -d ' ')"
    echo "subdirs: $(find . -mindepth 2 -type d | wc -l | tr -d ' ')"
  else
    ls **/*.$1 | wc -l
  fi
}

fsize() {
  local target="${1:-.}"
  local show_tree=false

  if [[ "$1" == "tree" ]]; then
    show_tree=true
    target="${2:-.}"
  fi

  if [[ -f "$target" ]]; then
    echo "  $target: $(du -sh "$target" | cut -f1)"
    return
  fi

  if [[ ! -d "$target" ]]; then
    echo "fsize: '$target' not found"
    return 1
  fi

  if $show_tree; then
    eza --icons --tree "$target"
    echo ""
  fi

  local size=$(du -sh "$target" | cut -f1)
  local files=$(find "$target" -type f | wc -l | tr -d ' ')

  echo "  Size:  $size"
  echo "  Files: $files"
  echo "  Types:"
  find "$target" -type f -name '*.*' | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -12 | while read count ext; do
    printf "    %4s  %s\n" "$count" "$ext"
  done
}

# Copy command output to clipboard (disable pagers)
cpl() {
  if [[ $# -eq 0 ]]; then
    echo "Usage: cpl <command> [args...]"
    return 1
  fi
  PAGER=cat "$@" 2>&1 | tee /dev/tty | sed 's/^/"/;s/$/"/' | pbcopy
}

# Editor
export EDITOR=nvim
export VISUAL=nvim

# television (fuzzy finder)
eval "$(tv init zsh)"
# Detect Homebrew prefix (portable across Intel/Apple Silicon)
if [[ -x /opt/homebrew/bin/brew ]]; then
  BREW_PREFIX=/opt/homebrew
else
  BREW_PREFIX=/usr/local
fi

# Prompt: Powerlevel10k
source $BREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Alternative: Oh My Posh (uncomment to switch back)
# eval "$(oh-my-posh init zsh --config ~/.config/zen-omp.toml)"
source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '\e ' autosuggest-accept

eval $(thefuck --alias)

# --- notez-cli shell integration (provided by the binary itself) ---
eval "$(notez init zsh)"
PATH=$(pyenv root)/shims:$PATH

# --- Dotfiles sync ---
alias dotup='dotsync && exec zsh'

_dotcore_section() {
  # Print non-empty entries from a [section], stripping inline `# comments`.
  awk -v sec="[$1]" '
    $0 == sec { in_sec = 1; next }
    /^\[/    { in_sec = 0 }
    in_sec {
      sub(/[ \t]*#.*$/, "")
      if (NF) print
    }
  ' ~/.dotfiles/.dotcore
}

_dotup_prompt_section() {
  # Optional section installer with per-host memory.
  # $1 = section name in .dotcore, $2 = human label, $3 = "brew" or "cask"
  local section="$1" label="$2" kind="$3"
  local prefs="$HOME/.dotup-prefs"
  [[ -f "$prefs" ]] || touch "$prefs"
  local key="$(hostname -s):$section"
  local items=$(_dotcore_section "$section")
  [[ -z "$items" ]] && return

  local cached=$(grep "^${key}=" "$prefs" | tail -1 | cut -d= -f2)
  local answer
  if [[ -n "$cached" ]]; then
    answer="$cached"
    echo "\n==> $label: remembered choice = $answer (edit ~/.dotup-prefs to change)"
  else
    echo "\n==> Optional: $label"
    echo "$items" | sed 's/^/    /'
    printf "  Install on this machine? [y/N] "
    read -r REPLY
    [[ "$REPLY" =~ ^[Yy]$ ]] && answer=yes || answer=no
    echo "${key}=${answer}" >> "$prefs"
  fi
  [[ "$answer" != yes ]] && return

  local installed
  [[ "$kind" == cask ]] && installed=$(brew list --cask -1) || installed=$(brew list --formula -1)
  local missing=()
  while IFS= read -r pkg; do
    echo "$installed" | grep -qx "$pkg" || missing+=("$pkg")
  done <<< "$items"
  if [[ ${#missing[@]} -gt 0 ]]; then
    echo "  Installing missing:"
    printf "    %s\n" "${missing[@]}"
    [[ "$kind" == cask ]] && brew install --cask "${missing[@]}" || brew install "${missing[@]}"
  fi
}

dotsync() {
  local startdir="$PWD"
  cd ~/.dotfiles || return 1

  echo "==> Pulling latest dotfiles..."
  git pull

  # --- Brew taps ---
  local missing_taps=()
  while IFS= read -r tap; do
    brew tap | grep -qx "$tap" || missing_taps+=("$tap")
  done < <(_dotcore_section tap)
  if [[ ${#missing_taps[@]} -gt 0 ]]; then
    echo "\n==> Adding brew taps..."
    for tap in "${missing_taps[@]}"; do brew tap "$tap"; done
  fi

  # --- Brew formulae ---
  local installed_formulae=$(brew list --formula -1)
  local missing_brew=()
  while IFS= read -r pkg; do
    echo "$installed_formulae" | grep -qx "$pkg" || missing_brew+=("$pkg")
  done < <(_dotcore_section brew; _dotcore_section brew-tap)
  if [[ ${#missing_brew[@]} -gt 0 ]]; then
    echo "\n==> Installing missing core formulae:"
    printf "  %s\n" "${missing_brew[@]}"
    brew install "${missing_brew[@]}"
  fi

  # --- Brew casks ---
  local installed_casks=$(brew list --cask -1)
  local missing_casks=()
  while IFS= read -r pkg; do
    echo "$installed_casks" | grep -qx "$pkg" || missing_casks+=("$pkg")
  done < <(_dotcore_section cask)
  if [[ ${#missing_casks[@]} -gt 0 ]]; then
    echo "\n==> Installing missing core casks:"
    printf "  %s\n" "${missing_casks[@]}"
    brew install --cask "${missing_casks[@]}"
  fi

  # --- Cargo packages ---
  local missing_cargo=()
  while IFS= read -r pkg; do
    cargo install --list 2>/dev/null | grep -q "^$pkg " || missing_cargo+=("$pkg")
  done < <(_dotcore_section cargo)
  if [[ ${#missing_cargo[@]} -gt 0 ]]; then
    echo "\n==> Installing missing cargo packages:"
    printf "  %s\n" "${missing_cargo[@]}"
    cargo install "${missing_cargo[@]}"
  fi

  # --- Pipx packages ---
  local installed_pipx=$(pipx list --short 2>/dev/null | awk '{print $1}')
  local missing_pipx=()
  while IFS= read -r pkg; do
    echo "$installed_pipx" | grep -qx "$pkg" || missing_pipx+=("$pkg")
  done < <(_dotcore_section pipx)
  if [[ ${#missing_pipx[@]} -gt 0 ]]; then
    echo "\n==> Installing missing pipx packages:"
    printf "  %s\n" "${missing_pipx[@]}"
    for pkg in "${missing_pipx[@]}"; do pipx install "$pkg"; done
  fi

  # --- Optional sections (prompt per machine, remembered in ~/.dotup-prefs) ---
  _dotup_prompt_section brew-langs "Language toolchains (kotlin, gradle, etc.)" brew
  _dotup_prompt_section cask-langs "Language SDKs (JDKs)" cask
  _dotup_prompt_section brew-db    "Databases (mysql, postgres)" brew

  # --- Stow core packages ---
  local stowed=0
  while IFS= read -r pkg; do
    [[ -d "$pkg" ]] || continue
    local has_link=false
    while IFS= read -r f; do
      local target="$HOME/${f#$pkg/}"
      [[ -L "$target" ]] && { has_link=true; break; }
    done < <(find "$pkg" -maxdepth 3 -type f 2>/dev/null)
    if ! $has_link; then
      echo "==> Stowing $pkg..."
      stow "$pkg" && ((stowed++))
    fi
  done < <(_dotcore_section stow)

  # --- Report optional unstowed packages ---
  local core_stow=$(_dotcore_section stow)
  local optional=()
  for dir in */; do
    [[ "$dir" == screenshots/ ]] && continue
    local pkg="${dir%/}"
    echo "$core_stow" | grep -qx "$pkg" && continue
    local has_link=false
    while IFS= read -r f; do
      local target="$HOME/${f#$pkg/}"
      [[ -L "$target" ]] && { has_link=true; break; }
    done < <(find "$pkg" -maxdepth 3 -type f 2>/dev/null)
    $has_link || optional+=("$pkg")
  done

  echo "\n==> Sync complete."
  [[ $stowed -gt 0 ]] && echo "  Stowed $stowed new core packages."
  if [[ ${#optional[@]} -gt 0 ]]; then
    echo "  Optional packages not stowed:"
    printf "    %s\n" "${optional[@]}"
  fi

  cd "$startdir"
}
eval "$(atuin init zsh)"
export COLUMNS
PATH=$(pyenv root)/shims:$PATH
PATH=$(pyenv root)/shims:$PATH
