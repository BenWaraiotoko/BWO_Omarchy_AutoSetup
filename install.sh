#!/usr/bin/env bash

# BWO Omarchy AutoSetup
# Post-install customization script for Omarchy Linux
# Run this AFTER Omarchy is already installed on your system.
#
# Usage:
#   git clone https://github.com/BenWaraiotoko/BWO-Omarchy-AutoSetup.git ~/Projects/BWO-Omarchy-AutoSetup
#   cd ~/Projects/BWO-Omarchy-AutoSetup
#   ./install.sh

set -eo pipefail

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_success() { echo -e "${GREEN}✅ $1${NC}"; }
log_warning() { echo -e "${YELLOW}⚠️  $1${NC}"; }
log_error()   { echo -e "${RED}❌ $1${NC}"; }
log_info()    { echo -e "ℹ️  $1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Verify we are on Omarchy / Arch-based system
if ! command -v yay &>/dev/null && ! command -v pacman &>/dev/null; then
  log_error "This script requires an Arch-based system with pacman/yay."
  log_error "Please run this on Omarchy Linux."
  exit 1
fi

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║       BWO Omarchy AutoSetup               ║"
echo "║  Personal customization for Omarchy Linux ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# ─────────────────────────────────────────────────────────────
# 1. Ensure yay is available (AUR helper)
# ─────────────────────────────────────────────────────────────
if ! command -v yay &>/dev/null; then
  echo "Installing yay (AUR helper)..."
  sudo pacman -S --needed --noconfirm git base-devel
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay && makepkg -si --noconfirm
  cd "$SCRIPT_DIR"
  log_success "yay installed"
else
  log_success "yay already available"
fi

# ─────────────────────────────────────────────────────────────
# 2. Install extra packages from bwo-packages.txt
# ─────────────────────────────────────────────────────────────
PACKAGES_FILE="$SCRIPT_DIR/bwo-packages.txt"
if [[ -f "$PACKAGES_FILE" ]]; then
  echo "Installing extra packages from bwo-packages.txt..."
  # Read non-comment, non-empty lines; strip inline comments and whitespace
  mapfile -t PACKAGES < <(grep -v '^\s*#' "$PACKAGES_FILE" | grep -v '^\s*$' | sed 's/\s*#.*//' | awk '{print $1}')
  if [[ ${#PACKAGES[@]} -gt 0 ]]; then
    yay -S --needed --noconfirm "${PACKAGES[@]}" || log_warning "Some packages failed to install — continuing"
    log_success "Extra packages installed"
  else
    log_info "No packages to install"
  fi
else
  log_warning "bwo-packages.txt not found — skipping extra package install"
fi

# ─────────────────────────────────────────────────────────────
# 3. Install SuperClaude Framework
# ─────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"

if command -v superclaude &>/dev/null; then
  log_success "SuperClaude already installed, checking for updates..."
  pipx upgrade superclaude 2>/dev/null || true
elif command -v pipx &>/dev/null; then
  echo "Installing SuperClaude Framework..."
  if pipx install superclaude; then
    if command -v superclaude &>/dev/null; then
      superclaude install
      superclaude doctor
      log_success "SuperClaude installed"
    else
      log_warning "SuperClaude installed but not in PATH yet"
      log_info "Run 'pipx ensurepath' and restart shell, then: superclaude install"
    fi
  else
    log_warning "Failed to install SuperClaude"
  fi
else
  log_warning "pipx not found — install python-pipx first, then run: pipx install superclaude && superclaude install"
fi

# ─────────────────────────────────────────────────────────────
# 4. Set up dotfiles by copying into Omarchy's config structure
# ─────────────────────────────────────────────────────────────
echo "Setting up BWO dotfiles..."
DOTFILES="$SCRIPT_DIR/dotfiles"

# Bash customization — appended via ~/.bashrc.d/ (Omarchy pattern)
BASHRC_D="$HOME/.bashrc.d"
mkdir -p "$BASHRC_D"

if [[ -f "$DOTFILES/bash/bwo-aliases.bash" ]]; then
  cp "$DOTFILES/bash/bwo-aliases.bash" "$BASHRC_D/bwo-aliases.bash"
  log_success "Bash aliases installed → ~/.bashrc.d/bwo-aliases.bash"
fi

if [[ -f "$DOTFILES/bash/bwo-exports.bash" ]]; then
  cp "$DOTFILES/bash/bwo-exports.bash" "$BASHRC_D/bwo-exports.bash"
  log_success "Bash exports installed → ~/.bashrc.d/bwo-exports.bash"
fi

# Ensure ~/.bashrc sources ~/.bashrc.d/
BASHRC="$HOME/.bashrc"
if [[ -f "$BASHRC" ]] && ! grep -q 'bashrc.d' "$BASHRC"; then
  cat >> "$BASHRC" << 'EOF'

# Load BWO custom scripts
for f in ~/.bashrc.d/*.bash; do
  [[ -r "$f" ]] && source "$f"
done
unset f
EOF
  log_success "~/.bashrc updated to source ~/.bashrc.d/"
fi

# Neovim config — merge with Omarchy's omarchy-nvim style
NVIM_PLUGINS="$HOME/.config/nvim/lua/plugins"
mkdir -p "$NVIM_PLUGINS"

for lua_file in "$DOTFILES"/nvim/.config/nvim/lua/plugins/*.lua; do
  [[ -f "$lua_file" ]] || continue
  dest="$NVIM_PLUGINS/$(basename "$lua_file")"
  if [[ ! -f "$dest" ]]; then
    cp "$lua_file" "$dest"
    log_success "Neovim plugin installed: $(basename "$lua_file")"
  else
    log_info "Skipping existing nvim plugin: $(basename "$lua_file") (already exists)"
  fi
done

# SuperClaude dotfiles
if [[ -d "$DOTFILES/superclaude/.claude" ]]; then
  CLAUDE_DIR="$HOME/.claude"
  mkdir -p "$CLAUDE_DIR/commands/sc"
  # Copy SC command files without overwriting existing installations
  for f in "$DOTFILES"/superclaude/.claude/commands/sc/*.md; do
    [[ -f "$f" ]] || continue
    dest="$CLAUDE_DIR/commands/sc/$(basename "$f")"
    [[ -f "$dest" ]] || cp "$f" "$dest"
  done
  log_success "SuperClaude commands available in ~/.claude/commands/sc/"
fi

# Obsidian vault config
OBSIDIAN_VAULT="$HOME/Documents/bwo-second-brain"
if [[ -d "$OBSIDIAN_VAULT" ]] && [[ -d "$DOTFILES/obsidian/.obsidian" ]]; then
  cp -r "$DOTFILES/obsidian/.obsidian" "$OBSIDIAN_VAULT/"
  log_success "Obsidian vault config restored"
elif [[ ! -d "$OBSIDIAN_VAULT" ]]; then
  log_warning "Obsidian vault not found at $OBSIDIAN_VAULT — skipping"
  log_info "Create the vault first, then run: cp -r dotfiles/obsidian/.obsidian ~/Documents/bwo-second-brain/"
fi

log_success "Dotfiles configured"

# ─────────────────────────────────────────────────────────────
# 5. Ghostty config
# ─────────────────────────────────────────────────────────────
GHOSTTY_CFG_SRC="$DOTFILES/ghostty/.config/ghostty/config"
GHOSTTY_CFG_DIR="$HOME/.config/ghostty"
if [[ -f "$GHOSTTY_CFG_SRC" ]]; then
  mkdir -p "$GHOSTTY_CFG_DIR"
  cp "$GHOSTTY_CFG_SRC" "$GHOSTTY_CFG_DIR/config"
  log_success "Ghostty config installed → ~/.config/ghostty/config"
fi

# ─────────────────────────────────────────────────────────────
# 6. Hyprland keybinding: Super+T → ghostty (keep Super+Shift+T for alacritty)
# ─────────────────────────────────────────────────────────────
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
if [[ -f "$HYPR_CONF" ]]; then
  # Replace alacritty binding on Super+T with ghostty, if not already done
  if grep -q 'bind.*SUPER.*,\s*T,\s*exec,\s*alacritty' "$HYPR_CONF"; then
    # Add ghostty binding before the alacritty line, change alacritty to SUPER+SHIFT+T
    sed -i \
      's/\(bind.*SUPER.*,\s*T,\s*exec,\s*alacritty\)/bind = SUPER, T, exec, ghostty\n# bind below kept for alacritty fallback (Super+Shift+T)\nbind = SUPER SHIFT, T, exec, alacritty/' \
      "$HYPR_CONF"
    log_success "Hyprland: Super+T → ghostty | Super+Shift+T → alacritty"
  elif grep -q 'bind.*SUPER.*,\s*T,\s*exec,\s*ghostty' "$HYPR_CONF"; then
    log_info "Hyprland keybinding already set to ghostty — skipping"
  else
    log_warning "Could not find Super+T alacritty binding in $HYPR_CONF — add manually:"
    log_info "  bind = SUPER, T, exec, ghostty"
  fi
else
  log_warning "Hyprland config not found at $HYPR_CONF — skipping keybinding update"
  log_info "Add manually: bind = SUPER, T, exec, ghostty"
fi

# ─────────────────────────────────────────────────────────────
# 7. Vim minimal config
# ─────────────────────────────────────────────────────────────
if [[ -f "$DOTFILES/vim/.vimrc" ]] && [[ ! -f "$HOME/.vimrc" ]]; then
  cp "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
  log_success "Vim config installed"
fi

# ─────────────────────────────────────────────────────────────
# 8. Done
# ─────────────────────────────────────────────────────────────
echo ""
echo "✅ BWO Omarchy AutoSetup complete!"
echo ""
echo "📝 Next steps:"
echo "  1. Restart your terminal — Ghostty is now bound to Super+T (Alacritty → Super+Shift+T)"
echo "  2. Restart Claude Code to access SuperClaude commands (type '/sc:')"
echo "  3. If new to Vim: run 'vimtutor' first, then graduate to 'nvim'"
echo "  4. Launch nvim once to let lazy.nvim install plugins"
echo ""
echo "⚡ SuperClaude Framework:"
echo "  - 30+ slash commands (type '/sc:' in Claude Code)"
echo "  - Run 'superclaude --help' for CLI commands"
echo ""
