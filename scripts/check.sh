#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$ROOT"

pass() { printf 'ok  %s\n' "$1"; }
fail() { printf 'error: %s\n' "$1" >&2; exit 1; }

bash -n scripts/install.sh scripts/check.sh
sh -n config/yazi/open-in-vim.sh
pass "shell syntax"

if command -v zsh >/dev/null 2>&1; then
  zsh -n config/tmux/layouts.zsh
  pass "zsh layout syntax"
fi

python3 - <<'PY'
import json
from pathlib import Path
for path in Path("config/pi").rglob("*.json"):
    json.loads(path.read_text())
PY
pass "Pi JSON"

python3 - <<'PY'
import sys
from pathlib import Path
try:
    import tomllib
except ImportError:
    print("warning: Python 3.11+ required for TOML validation", file=sys.stderr)
    raise SystemExit(0)
for path in Path("config/yazi").glob("*.toml"):
    tomllib.loads(path.read_text())
PY
pass "yazi TOML"

if command -v vim >/dev/null 2>&1; then
  vim -Nu NONE -n -es "+set runtimepath^=$ROOT/config/vim" "+colorscheme ayu2" +qall
  pass "Vim theme"
fi

if command -v tmux >/dev/null 2>&1; then
  tmux_version=$(tmux -V | awk '{print $2}')
  if awk -v v="$tmux_version" 'BEGIN { split(v, n, "."); exit !((n[1] + 0) > 3 || ((n[1] + 0) == 3 && (n[2] + 0) >= 5)) }'; then
    socket="yapi-check-$$"
    trap 'tmux -L "$socket" kill-server 2>/dev/null || true' EXIT
    output=$(tmux -L "$socket" -f config/tmux/tmux.conf new-session -d 2>&1) || fail "tmux config: $output"
    tmux -L "$socket" kill-server 2>/dev/null || true
    trap - EXIT
    pass "tmux config"
  else
    echo "warning: tmux $tmux_version is too old for CSI-u validation (requires 3.5+)" >&2
  fi
fi

if git grep -nEI '(sk-ant-|sk-or-v1-|sk-[A-Za-z0-9_-]{24,}|AIza[0-9A-Za-z_-]{20,}|BEGIN (RSA |OPENSSH |EC )?PRIVATE KEY)' -- . ':!scripts/check.sh'; then
  fail "possible secret detected"
fi
pass "secret scan"

echo "All checks passed."
