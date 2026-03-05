# BWO Bash Exports for Omarchy
# Sourced from ~/.bashrc.d/bwo-exports.bash

# ─────────────────────────────────────────────────────────────
# PATH additions
# ─────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$PATH"
export PATH="./node_modules/.bin:$PATH"

# ─────────────────────────────────────────────────────────────
# Editor
# ─────────────────────────────────────────────────────────────
export EDITOR="nvim"
export VISUAL="nvim"

# ─────────────────────────────────────────────────────────────
# Node.js
# ─────────────────────────────────────────────────────────────
export NODE_OPTIONS="--max-old-space-size=8192"

# nvm (Node Version Manager) — if installed
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# ─────────────────────────────────────────────────────────────
# Python / pipx
# ─────────────────────────────────────────────────────────────
export PATH="$HOME/.local/share/pipx/venvs:$PATH"
if command -v pipx &>/dev/null; then
  eval "$(register-python-argcomplete pipx)" 2>/dev/null || true
fi

# ─────────────────────────────────────────────────────────────
# Ripgrep / FZF integration
# ─────────────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
