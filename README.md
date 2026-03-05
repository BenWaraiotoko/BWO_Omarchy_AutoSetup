# BWO-Omarchy-AutoSetup

Personal post-install customization layer for [Omarchy](https://omarchy.org) — a keyboard-driven Linux distribution by DHH built on Arch, Hyprland, and Neovim.

This project installs extra packages and personal dotfiles **on top of** a working Omarchy installation, mirroring the workflow from [BWO-MacAutoSetup](https://github.com/BenWaraiotoko/BWO-MacAutoSetup) but adapted for Linux/Omarchy.

## Acknowledgments

- [basecamp/omarchy](https://github.com/basecamp/omarchy) — the foundation this builds on
- [BenWaraiotoko/BWO-MacAutoSetup](https://github.com/BenWaraiotoko/BWO-MacAutoSetup) — the macOS counterpart

---

## What This Adds

On top of everything Omarchy already provides (Hyprland, Alacritty, Neovim/omarchy-nvim, LazyGit, Obsidian, Spotify, 1Password, Claude Code, Docker, etc.), this setup adds:

**Extra CLI Tools**
- `lazysql` — terminal SQL client TUI
- `go-yq` — YAML processor (binary: `yq`)
- `git-delta` — beautiful git diffs (binary: `delta`)
- `csvlens` — interactive CSV viewer
- `glow` — Markdown renderer in terminal
- `chafa` — render images in terminal
- `ranger` — VIM-inspired file manager

**Extra Languages & Runtimes**
- `nodejs`, `npm`, `nvm`
- `python-pipx` for isolated CLI tool installs

**Cloud & DevOps**
- `aws-cli-v2`, `kubectl`, `tailscale`

**Extra GUI Apps**
- `ghostty` — GPU-accelerated terminal (Super+T, Alacritty moves to Super+Shift+T)
- `zed` — fast, collaborative code editor
- `discord`, `proton-vpn-gtk-app`, `protonmail-bridge`, `postman-bin`, `notion-app-electron`

**SuperClaude Framework**
- 30+ slash commands for Claude Code (`/sc:analyze`, `/sc:implement`, etc.)
- 11 specialized AI personas

**Personal Dotfiles**
- Bash aliases & exports (compatible with Omarchy's bash environment)
- Neovim: Catppuccin Mocha theme + beginner-friendly which-key config
- Ghostty: Catppuccin Mocha theme, JetBrainsMono Nerd Font
- Zed: Catppuccin Mocha theme, JetBrainsMono Nerd Font, Ollama integration
- Minimal Vim config for learning
- SuperClaude commands for Claude Code

---

## Quick Start

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

## Project Structure

```
BWO-Omarchy-AutoSetup/
├── install.sh              # Main setup script
├── bwo-packages.txt        # Extra packages (pacman/AUR)
├── dotfiles/
│   ├── bash/               # Bash aliases & exports (-> ~/.bashrc.d/)
│   ├── vim/                # Minimal .vimrc for learning
│   ├── nvim/               # Neovim plugin configs (merged into ~/.config/nvim/)
│   ├── ghostty/            # Ghostty config (-> ~/.config/ghostty/)
│   ├── zed/                # Zed config (-> ~/.config/zed/)
│   ├── superclaude/        # SuperClaude Framework commands
│   └── obsidian/           # Obsidian vault config (copied, not stowed)
└── docs/
    ├── VIM_LEARNING_GUIDE.md
    └── TOOLS.md
```

---

## What Gets Installed

### Package Strategy

Omarchy already includes most tools. `bwo-packages.txt` only adds what's missing.

Note: some package names differ from the binary name — this is an Arch convention.

| Tool | Package name | Binary | Source |
|------|-------------|--------|--------|
| YAML processor | `go-yq` | `yq` | official |
| Git diff viewer | `git-delta` | `delta` | official |
| Proton VPN | `proton-vpn-gtk-app` | — | official |
| Proton Mail Bridge | `protonmail-bridge` | — | official |
| Postman | `postman-bin` | — | AUR |
| Notion | `notion-app-electron` | — | AUR |
| lazysql | `lazysql` | — | AUR |
| Everything else | same name | — | official |

### Dotfile Strategy

Unlike the macOS version (which used GNU Stow), this project uses **copy-based deployment** compatible with Omarchy's existing config management:

- Bash customizations -> `~/.bashrc.d/` (sourced by `~/.bashrc`)
- Neovim plugins -> `~/.config/nvim/lua/plugins/` (merged, not replaced)
- Ghostty config -> `~/.config/ghostty/config`
- Zed config -> `~/.config/zed/settings.json`
- Vim config -> `~/.vimrc`
- SuperClaude -> `~/.claude/commands/sc/`

---

## Key Components

### Terminal Setup

Omarchy ships with **Alacritty**. This setup adds **Ghostty** alongside it:

- `Super + T` — Ghostty
- `Super + Shift + T` — Alacritty (fallback)

Ghostty config: Catppuccin Mocha theme, JetBrainsMono Nerd Font 16px, 120x36 default window size.

### Shell Environment

Omarchy uses **bash** with [starship](https://starship.rs) prompt. BWO adds:
- Personal aliases in `~/.bashrc.d/bwo-aliases.bash`
- PATH and environment exports in `~/.bashrc.d/bwo-exports.bash`

### Editor Setup

**Omarchy Neovim** (`omarchy-nvim`) is the default. BWO adds:
- Catppuccin Mocha theme with transparent background
- Faster which-key hints (200ms)

**Minimal Vim** at `~/.vimrc` — zero plugins, for learning fundamentals:
1. Start with `vimtutor`
2. Move to `nvim` when comfortable

### Zed Editor

Zed config: Catppuccin Mocha theme, JetBrainsMono Nerd Font, VSCode keymap.

AI integration via Ollama (local) — uses `devstral-small-2` for both the agent and inline edit predictions. Make sure Ollama is running and the model is pulled:

```bash
ollama pull devstral-small-2
```

The config skips overwriting if `~/.config/zed/settings.json` already exists, so your existing Zed settings are safe.

### SuperClaude Framework

AI-enhanced development workflow:
- 30+ slash commands (type `/sc:` in Claude Code)
- Run `superclaude --help` for CLI

---

## Post-Install Steps

1. Restart your terminal — Ghostty is now on Super+T, Alacritty on Super+Shift+T
2. Restart Claude Code to load SuperClaude commands
3. Launch `nvim` once to let lazy.nvim install plugins automatically
4. Run `vimtutor` if you're new to Vim

---

## Troubleshooting

**Package install fails**
```bash
# Check which package failed
yay -S --needed <package-name>

# Search for the correct package name
yay -Ss <search-term>
```

**Bash aliases not loading**
```bash
ls ~/.bashrc.d/
source ~/.bashrc.d/bwo-aliases.bash
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

## Related Projects

- [basecamp/omarchy](https://github.com/basecamp/omarchy) — Omarchy Linux
- [BenWaraiotoko/BWO-MacAutoSetup](https://github.com/BenWaraiotoko/BWO-MacAutoSetup) — macOS counterpart
- [NLaundry/SuperClaude](https://github.com/NLaundry/SuperClaude) — Claude Code enhancement framework
