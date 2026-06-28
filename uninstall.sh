#!/usr/bin/env bash
# ============================================================================
#  uninstall.sh — remove the symlink and restore the most recent backup if any.
# ============================================================================
set -euo pipefail

DEST="$HOME/.tmux.conf"

ok()   { printf '  \033[32m✓\033[0m %s\n' "$*"; }
warn() { printf '  \033[33m!\033[0m %s\n' "$*"; }

if [ -L "$DEST" ]; then
  rm -f "$DEST"
  ok "removed symlink $DEST"
else
  warn "$DEST is not our symlink — leaving it untouched"
fi

# Restore the newest backup, if one exists
BACKUP="$(ls -1t "$HOME"/.tmux.conf.backup.* 2>/dev/null | head -n1 || true)"
if [ -n "${BACKUP:-}" ]; then
  mv "$BACKUP" "$DEST"
  ok "restored $DEST from $BACKUP"
fi

echo "Done."
