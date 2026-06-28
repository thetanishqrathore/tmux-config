#!/usr/bin/env bash
# ============================================================================
#  install.sh — symlink this tmux config into place and reload tmux.
#  Idempotent: safe to run multiple times. Backs up any existing ~/.tmux.conf.
# ============================================================================
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$REPO_DIR/tmux.conf"
DEST="$HOME/.tmux.conf"

bold() { printf '\033[1m%s\033[0m\n' "$*"; }
info() { printf '  \033[36m•\033[0m %s\n' "$*"; }
ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }

bold "tmux-config installer"

# 1. Check tmux is present
if ! command -v tmux >/dev/null 2>&1; then
  warn "tmux is not installed."
  if command -v apt-get >/dev/null 2>&1; then
    info "Install it with: sudo apt-get update && sudo apt-get install -y tmux"
  elif command -v brew >/dev/null 2>&1; then
    info "Install it with: brew install tmux"
  elif command -v dnf >/dev/null 2>&1; then
    info "Install it with: sudo dnf install -y tmux"
  fi
  exit 1
fi
ok "found $(tmux -V)"

# 2. Back up an existing real config (not our symlink)
if [ -e "$DEST" ] && [ ! -L "$DEST" ]; then
  BACKUP="$DEST.backup.$(date +%Y%m%d%H%M%S)"
  mv "$DEST" "$BACKUP"
  warn "backed up existing ~/.tmux.conf -> $BACKUP"
elif [ -L "$DEST" ]; then
  rm -f "$DEST"
fi

# 3. Symlink the config into place
ln -s "$SRC" "$DEST"
ok "linked $DEST -> $SRC"

# 4. Reload if a server is running
if tmux info >/dev/null 2>&1; then
  tmux source-file "$DEST" >/dev/null 2>&1 || true
  ok "reloaded running tmux server"
else
  info "no tmux server running yet — config applies on next 'tmux' start"
fi

bold "Done."
echo
echo "  Prefix is Ctrl-a. Start tmux with:  tmux"
echo "  Reload anytime with:  Ctrl-a then r"
echo "  Cheatsheet:  see README.md"
