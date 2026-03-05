# CLI Tools Reference

Quick reference for the tools installed by BWO-Omarchy-AutoSetup.
Tools already in Omarchy base are marked with *(Omarchy)*.

## File Navigation & Viewing

| Tool | Command | Description |
|------|---------|-------------|
| eza *(Omarchy)* | `ls`, `ll`, `lt` | Modern ls with icons and git status |
| bat *(Omarchy)* | `cat <file>` | Syntax-highlighted file viewer |
| ranger | `ranger` | VIM-inspired terminal file manager |
| fzf *(Omarchy)* | `Ctrl+R`, `Ctrl+T` | Fuzzy finder for files and history |
| fd *(Omarchy)* | `fd <pattern>` | Fast `find` alternative |
| ripgrep *(Omarchy)* | `rg <pattern>` | Fast `grep` replacement |

## System Monitoring

| Tool | Command | Description |
|------|---------|-------------|
| btop *(Omarchy)* | `btop` | Beautiful resource monitor |
| dust *(Omarchy)* | `dust` | Intuitive disk usage viewer |

## Data Processing

| Tool | Command | Description |
|------|---------|-------------|
| jq *(Omarchy)* | `jq '.' file.json` | JSON processor |
| yq | `yq '.' file.yaml` | YAML/JSON processor |
| csvlens | `csvlens file.csv` | Interactive CSV viewer |
| delta | `git diff` | Beautiful git diffs (auto-configured) |

## Content Viewing

| Tool | Command | Description |
|------|---------|-------------|
| glow | `glow README.md` | Render Markdown in terminal |
| chafa | `chafa image.png` | Display images in terminal |
| tldr *(Omarchy)* | `tldr <command>` | Simplified man pages |

## Version Control

| Tool | Command | Description |
|------|---------|-------------|
| lazygit *(Omarchy)* | `lazygit` or `lg` | Terminal UI for Git |
| lazysql | `lazysql` | Terminal SQL client |
| github-cli *(Omarchy)* | `gh` | GitHub CLI |
| delta | git diff viewer | Configured via ~/.gitconfig |

## AI Tools

| Tool | Command | Description |
|------|---------|-------------|
| claude-code *(Omarchy)* | `claude` | Claude Code editor integration |
| opencode *(Omarchy)* | `opencode` | Open-source AI coding |
| ollama | `ollama run <model>` | Run local LLMs |
| superclaude | `superclaude --help` | Enhanced Claude Code framework |

## Package Management

| Tool | Command | Description |
|------|---------|-------------|
| yay | `yay -S <pkg>` | AUR helper (wraps pacman) |
| pkgup | `pkgup` | Full system upgrade (alias) |
| pkgin | `pkgin <pkg>` | Install package (alias) |
| pkgs | `pkgs <term>` | Search packages (alias) |

## Useful Aliases (from bwo-aliases.bash)

```bash
ls   → eza --icons
ll   → eza -la --icons --git
lt   → eza --tree --level=2 --icons
cat  → bat --style=plain
g    → git
lg   → lazygit
v    → nvim
d    → docker
dc   → docker compose
```
