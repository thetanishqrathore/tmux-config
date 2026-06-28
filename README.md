# tmux-config

A convenient, **self-contained** tmux configuration. One file, no plugins, no
plugin manager — clone and run `install.sh`. Tested on **tmux 3.4** (Ubuntu 24.04),
works on tmux ≥ 3.2.

## Features

- **Ctrl-Space** prefix — ergonomic and conflict-free (frees the default `Ctrl-b`).
- **Mouse on** — click panes, drag borders to resize, scroll to enter copy mode.
- **System clipboard** over SSH via OSC 52 — no `xclip`/`pbcopy` needed.
- **Vim-style** pane navigation, copy mode, and resizing.
- Intuitive splits (`|` and `-`) that **keep the current directory**.
- True-color status bar, sensible scrollback (50k), fast key response.
- Optional per-machine overrides via `~/.tmux.conf.local` (git-ignored).

## Install

```bash
git clone https://github.com/<you>/tmux-config.git ~/tmux-config
cd ~/tmux-config
./install.sh
```

The installer symlinks `tmux.conf` to `~/.tmux.conf`, backs up any existing
config, and reloads a running tmux server. Re-run it anytime; it's idempotent.

Start tmux with `tmux`. Reload the config without restarting: **`Ctrl-Space` then `r`**.

### Don't have tmux yet?

```bash
sudo apt-get update && sudo apt-get install -y tmux   # Debian/Ubuntu
brew install tmux                                      # macOS
sudo dnf install -y tmux                               # Fedora/RHEL
```

## Uninstall

```bash
./uninstall.sh   # removes the symlink, restores your latest backup
```

## Cheatsheet

> Prefix = **`Ctrl-Space`**. Notation: `prefix r` means press `Ctrl-Space`, release, then `r`.

### Sessions, windows, panes
| Keys | Action |
|------|--------|
| `prefix c` | New window (in current directory) |
| `prefix ,` | Rename window |
| `prefix n` / `prefix p` | Next / previous window (repeatable) |
| `Shift-←` / `Shift-→` | Previous / next window (no prefix) |
| `prefix Tab` | Last (most recent) window |
| `prefix 1..9` | Jump to window N |
| `prefix d` | Detach session |
| `prefix \|` | Split vertically (keep directory) |
| `prefix -` | Split horizontally (keep directory) |
| `prefix x` | Close pane |
| `prefix &` | Close window |

### Navigation & layout
| Keys | Action |
|------|--------|
| `prefix h/j/k/l` | Move to pane left/down/up/right |
| `Alt-←/↓/↑/→` | Move between panes (no prefix) |
| `prefix H/J/K/L` | Resize pane (repeatable — hold and tap) |
| `prefix m` or `prefix z` | Toggle pane zoom (fullscreen) |
| `prefix Space` | Cycle pane layouts |
| `prefix e` | Toggle synchronize-panes (type into all panes) |
| `prefix q` | Show pane numbers |

### Copy mode (Vim style)
| Keys | Action |
|------|--------|
| `prefix Enter` | Enter copy mode |
| `v` | Begin selection |
| `Ctrl-v` | Toggle rectangle (block) selection |
| `y` | Copy selection → system clipboard, exit |
| `Escape` / `q` | Cancel copy mode |
| `prefix P` | Paste tmux buffer |
| mouse drag | Select; release copies |

> Mouse selection also copies to the system clipboard. To use your terminal's
> native copy/paste instead, hold **Shift** while selecting.

### Misc
| Keys | Action |
|------|--------|
| `prefix r` | Reload `~/.tmux.conf` |
| `prefix ?` | List all key bindings |
| `prefix :` | tmux command prompt |

## Customizing

Edit `tmux.conf` and re-run `./install.sh` (or `prefix r` to reload). For
machine-specific tweaks you don't want to commit, drop them in
`~/.tmux.conf.local` — it's sourced automatically and ignored by git.

To change the prefix, edit these lines near the top of `tmux.conf`:

```tmux
set -g prefix C-Space
bind C-Space send-prefix
```

## Notes

- **Clipboard over SSH:** copy uses OSC 52, so your local terminal must allow it
  (iTerm2: *Allow access to clipboard*; most modern terminals support it).
- **Colors look off?** Make sure your terminal advertises true color and start
  tmux from a `TERM` like `xterm-256color`. The config sets `tmux-256color`
  internally with `Tc` overrides.

## License

MIT — see [LICENSE](LICENSE).
