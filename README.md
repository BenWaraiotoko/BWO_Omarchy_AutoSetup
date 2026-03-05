# BWO-Omarchy-AutoSetup

Personal post-install customization layer for [Omarchy](https://omarchy.org) — a beautiful, modern & opinionated Linux distribution by DHH.

This project installs extra packages and personal dotfiles **on top of** a working Omarchy installation, mirroring the workflow from [BWO-MacAutoSetup](https://github.com/BenWaraiotoko/BWO-MacAutoSetup) but adapted for Linux/Omarchy.

## 🙏 Acknowledgments

- [basecamp/omarchy](https://github.com/basecamp/omarchy) — the foundation this builds on
- [BenWaraiotoko/BWO-MacAutoSetup](https://github.com/BenWaraiotoko/BWO-MacAutoSetup) — the macOS counterpart

---

## ✨ What This Adds

On top of everything Omarchy already provides (Hyprland WM, Alacritty, Neovim/omarchy-nvim, LazyGit, Obsidian, Spotify, 1Password, Claude Code, Docker, etc.), this setup adds:

**Extra CLI Tools**
- `lazysql` — terminal SQL client TUI
- `yq` — YAML processor
- `delta` — beautiful git diffs
- `csvlens` — interactive CSV viewer
- `glow` — Markdown renderer in terminal
- `chafa` — render images in terminal
- `ranger` — VIM-inspired file manager

**Extra Languages & Runtimes**
- `nodejs` / `npm` / `nvm`
- `python-pipx` for isolated CLI tool installs

**Cloud & DevOps**
- `aws-cli-v2`, `kubectl`, `tailscale`

**Extra GUI Apps**
- Discord, ProtonVPN, Proton Mail Bridge, Postman, Notion

**SuperClaude Framework**
- 30+ slash commands for Claude Code (`/sc:analyze`, `/sc:implement`, etc.)
- 11 specialized AI personas

**Personal Dotfiles**
- Bash aliases & exports (compatible with Omarchy's bash environment)
- Neovim: Catppuccin Mocha theme + beginner-friendly which-key config
- Minimal Vim config for learning
- SuperClaude commands for Claude Code

---

## 🚀 Quick Start

### Prerequisites

1. Install [Omarchy](https://omarchy.org) first
2. Boot into your Omarchy desktop
3. Open a terminal

### Install

```bash
git clone https://github.com/BenWaraiotoko/BWO-Omarchy-AutoSetup.git ~/Projects/BWO-Omarchy-AutoSetup
cd ~/Projects/BWO-Omarchy-AutoSetup
./install.sh
```

---

## 📁 Project Structure

```
BWO-Omarchy-AutoSetup/
├── install.sh              # Main setup script
├── bwo-packages.txt        # Extra packages (pacman/AUR)
├── dotfiles/
│   ├── bash/               # Bash aliases & exports (→ ~/.bashrc.d/)
│   ├── vim/                # Minimal .vimrc for learning
│   ├── nvim/               # Neovim plugin configs (merged into ~/.config/nvim/)
│   ├── superclaude/        # SuperClaude Framework commands
│   └── obsidian/           # Obsidian vault config (copied, not stowed)
└── docs/
    ├── VIM_LEARNING_GUIDE.md
    └── TOOLS.md
```

---

## 🛠 What Gets Installed

### Package Strategy

Omarchy already includes most tools. `bwo-packages.txt` only adds what's missing:

| Category | Already in Omarchy | Added by BWO |
|---|---|---|
| Terminal | alacritty, bat, btop, eza, fzf, fastfetch | lazysql, yq, delta, csvlens, glow, chafa, ranger |
| Editors | neovim (omarchy-nvim) | minimal .vimrc for learning |
| Version Control | lazygit, github-cli | delta |
| AI | claude-code, opencode | SuperClaude Framework, ollama |
| Security | 1password, 1password-cli | protonvpn-gui, proton-mail-bridge |
| Containers | docker, lazydocker | — |
| Productivity | obsidian, spotify | discord, notion, postman |
| Languages | ruby, rust | nodejs, npm, nvm, python-pipx |
| DevOps | — | kubectl, aws-cli-v2, tailscale |

### Dotfile Strategy

Unlike the macOS version (which used GNU Stow), this project uses **copy-based deployment** compatible with Omarchy's existing config management:

- Bash customizations → `~/.bashrc.d/` (sourced by `~/.bashrc`)
- Neovim plugins → `~/.config/nvim/lua/plugins/` (merged, not replaced)
- Vim config → `~/.vimrc`
- SuperClaude → `~/.claude/commands/sc/`

---

## 🔧 Key Components

### Shell Environment

Omarchy uses **bash** with [starship](https://starship.rs) prompt. BWO adds:
- Personal aliases in `~/.bashrc.d/bwo-aliases.bash`
- PATH and environment exports in `~/.bashrc.d/bwo-exports.bash`

### Window Manager (Hyprland)

Omarchy already configures Hyprland with keyboard-driven navigation. Default keybindings:
- `Super + Return` — open terminal
- `Super + 1-9` — switch workspaces
- `Super + Q` — close window
- See Omarchy docs for full reference

### Editor Setup

**Omarchy Neovim** (`omarchy-nvim`) is the default. BWO adds:
- Catppuccin Mocha theme with transparent background
- Faster which-key hints (200ms)

**Minimal Vim** at `~/.vimrc` — zero plugins, for learning fundamentals:
1. Start: `vimtutor`
2. Graduate to `nvim` when comfortable

### SuperClaude Framework

AI-enhanced development workflow:
- 30+ slash commands (type `/sc:` in Claude Code)
- Run `superclaude --help` for CLI

---

## 📝 Post-Install Steps

1. **Restart terminal** — `source ~/.bashrc` or open a new terminal
2. **Restart Claude Code** — to load SuperClaude commands
3. **Launch nvim once** — lets lazy.nvim install plugins automatically
4. **Start with vimtutor** — if new to Vim: `vimtutor`

---

## 🔍 Troubleshooting

**Package install fails**
```bash
# Check which package failed
yay -S --needed <package-name>

# Search for the correct package name
yay -Ss <search-term>
```

**Bash aliases not loading**
```bash
# Check ~/.bashrc.d/ was created
ls ~/.bashrc.d/

# Manually source
source ~/.bashrc.d/bwo-aliases.bash

# Ensure ~/.bashrc has the sourcing block
grep -n 'bashrc.d' ~/.bashrc
```

**SuperClaude not available**
```bash
pipx ensurepath
source ~/.bashrc
superclaude install
superclaude doctor
```

**Neovim plugins not loading**
```bash
nvim  # first launch auto-installs via lazy.nvim
# inside nvim:
:Lazy sync
```

---

## 🔗 Related Projects

- [basecamp/omarchy](https://github.com/basecamp/omarchy) — Omarchy Linux
- [BenWaraiotoko/BWO-MacAutoSetup](https://github.com/BenWaraiotoko/BWO-MacAutoSetup) — macOS counterpart
- [LazyVim/LazyVim](https://github.com/LazyVim/LazyVim) — Neovim distribution
- [SuperClaude](https://github.com/NLaundry/SuperClaude) — Claude Code enhancement

---

*Built for Omarchy Linux | Keyboard-Driven Workflow | Terminal-First Development*
