# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

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
alias lz="eza --icons --group-directories-first --grid"
alias ls="eza --icons --group-directories-first"
alias ll="eza --icons --group-directories-first --long"
alias la="eza --icons --group-directories-first --long --all"
alias tree="eza --icons --tree"
alias cat="bat"
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
# Prompt: Powerlevel10k
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Alternative: Oh My Posh (uncomment to switch back)
# eval "$(oh-my-posh init zsh --config ~/.config/zen-omp.toml)"
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '\e ' autosuggest-accept

eval $(thefuck --alias)

# --- Notes ---
NOTES_DIR="$HOME/notes"

note() {
  local date=$(date +%Y-%m-%d)
  local title="${1:-untitled}"
  local dir="$NOTES_DIR/0_quick-notes"
  mkdir -p "$dir"
  local file="$dir/${date}-${title}.md"
  echo "# ${title}\n\nDate: ${date}\n" > "$file"
  $EDITOR "+4" -c "startinsert" "$file"
}

notes() {
  local folder=$(find "$NOTES_DIR" -maxdepth 1 -type d ! -path "$NOTES_DIR" -exec basename {} \; | sort | fzf --prompt="Pick a folder: " --tac)
  [[ -z "$folder" ]] && return

  local target="$NOTES_DIR/$folder"

  while true; do
    local subdirs=$(find "$target" -maxdepth 1 -type d ! -path "$target" 2>/dev/null)
    [[ -z "$subdirs" ]] && break
    local sub=$({ echo "."; find "$target" -maxdepth 1 -type d ! -path "$target" -exec basename {} \; | sort } | fzf --prompt="$(basename $target)/ (. = here) > " --tac --preview "[[ {} != '.' ]] && eza --tree --only-dirs '$target/{}' || echo 'Place note here'")
    [[ -z "$sub" ]] && return
    [[ "$sub" == "." ]] && break
    target="$target/$sub"
  done

  printf "Note title: "
  read title
  [[ -z "$title" ]] && return

  local date=$(date +%Y-%m-%d)
  local file="$target/${date}-${title}.md"
  echo "# ${title}\n\nDate: ${date}\n" > "$file"
  $EDITOR "+4" -c "startinsert" "$file"
}

search_notes() {
  rg "$1" "$NOTES_DIR" | fzf --preview 'bat --color=always $(echo {} | cut -d: -f1)'
}

log() {
  local date=$(date +%Y-%m-%d)
  local file="$NOTES_DIR/0_quick-notes/daily-${date}.md"
  mkdir -p "$NOTES_DIR/0_quick-notes"
  if [[ ! -f "$file" ]]; then
    echo "# Work Log - ${date}\n" > "$file"
  fi
  echo "$(date +%H:%M) - $*" >> "$file"
}
PATH=$(pyenv root)/shims:$PATH
PATH=$(pyenv root)/shims:$PATH
PATH=$(pyenv root)/shims:$PATH
