# BWO Bash Aliases for Omarchy
# Sourced from ~/.bashrc.d/bwo-aliases.bash
# Compatible with Omarchy's bash environment

# ─────────────────────────────────────────────────────────────
# eza — modern ls (already installed via bwo-packages.txt)
# ─────────────────────────────────────────────────────────────
if command -v eza &>/dev/null; then
  alias ls="eza --icons"
  alias ll="eza -la --icons --git"
  alias lt="eza --tree --level=2 --icons"
  alias la="eza -a --icons"
fi

# ─────────────────────────────────────────────────────────────
# Git shortcuts
# ─────────────────────────────────────────────────────────────
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"

# ─────────────────────────────────────────────────────────────
# Navigation
# ─────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# ─────────────────────────────────────────────────────────────
# Editors
# ─────────────────────────────────────────────────────────────
alias vi="vim"
alias v="nvim"
alias nv="nvim"

# ─────────────────────────────────────────────────────────────
# Claude Code
# ─────────────────────────────────────────────────────────────
alias claude="claude-code"

# ─────────────────────────────────────────────────────────────
# Docker / Containers (Omarchy uses Docker natively)
# ─────────────────────────────────────────────────────────────
alias d="docker"
alias dc="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"

# ─────────────────────────────────────────────────────────────
# System
# ─────────────────────────────────────────────────────────────
alias pkgup="yay -Syu --noconfirm"           # Full system upgrade
alias pkgin="yay -S --needed"                # Install package
alias pkgs="yay -Ss"                         # Search packages
alias pkginfo="yay -Qi"                      # Package info
alias pkgrm="yay -Rns"                       # Remove package + deps

# ─────────────────────────────────────────────────────────────
# bat — better cat (already in Omarchy)
# ─────────────────────────────────────────────────────────────
if command -v bat &>/dev/null; then
  alias cat="bat --style=plain"
  alias catn="bat"
fi
