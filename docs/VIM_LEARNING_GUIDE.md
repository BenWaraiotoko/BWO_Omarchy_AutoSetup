# Vim/Neovim Learning Guide

## Learning Path

### Stage 1: Vim Basics (Start Here)

Use the minimal `~/.vimrc` config (no plugins) to learn core motions.

```bash
vimtutor    # interactive tutorial (~30 minutes)
vim file    # practice on real files
```

**Essential motions to master first:**
- `h j k l` — left, down, up, right
- `w b e` — word forward, back, end
- `gg G` — file start, file end
- `0 $` — line start, line end

**Essential operations:**
- `i a o` — insert before, after, new line below
- `d y p` — delete, yank (copy), paste
- `u Ctrl+r` — undo, redo
- `:w :q :wq` — save, quit, save+quit

### Stage 2: Neovim + LazyVim (omarchy-nvim)

When comfortable with Stage 1, launch nvim:

```bash
nvim    # first launch auto-installs plugins via lazy.nvim
```

**Key LazyVim bindings:**
- `Space` — open which-key command palette
- `Space f f` — find files (Telescope)
- `Space f g` — live grep (search file contents)
- `Space g g` — open LazyGit
- `Space e` — file explorer (neo-tree)
- `g d` — go to definition
- `K` — hover documentation

**Neovim-specific motions:**
- `Ctrl+d / Ctrl+u` — scroll down/up (centered)
- `%` — jump to matching bracket
- `*` — search word under cursor

## Cheat Sheet

```
MODES:
  Normal  → i/a/o to insert, v to visual, : for command
  Insert  → Esc to return to normal
  Visual  → d/y to delete/yank selection

NAVIGATION:
  hjkl         left/down/up/right
  w/b/e        word forward/back/end
  0/$          line start/end
  gg/G         file start/end
  Ctrl+d/u     half-page down/up

EDITING:
  i/a          insert before/after cursor
  o/O          new line below/above
  dd           delete line
  yy           yank (copy) line
  p/P          paste after/before
  u / Ctrl+r   undo/redo
  .            repeat last change
  ciw          change inner word
  di"          delete inside quotes

SEARCH:
  /pattern     search forward
  n/N          next/previous match
  *            search word under cursor
  :%s/old/new/g  replace all

SPLITS:
  :sp / :vs    horizontal/vertical split
  Ctrl+hjkl    navigate between splits
```
