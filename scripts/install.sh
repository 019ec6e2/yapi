#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
BACKUP_ROOT=${YAPI_BACKUP_DIR:-"$HOME/.local/state/yapi/backups/$(date +%Y%m%d-%H%M%S)"}
INSTALL_PACKAGES=1
INSTALL_PLUGINS=1

usage() {
  cat <<'EOF'
Usage: ./scripts/install.sh [options]

Options:
  --link-only    Only back up and link configuration files
  --no-plugins   Skip TPM and Vundle plugin installation
  -h, --help     Show this help
EOF
}

while (($#)); do
  case "$1" in
    --link-only) INSTALL_PACKAGES=0; INSTALL_PLUGINS=0 ;;
    --no-plugins) INSTALL_PLUGINS=0 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

install_packages() {
  if [[ $(uname -s) == Darwin ]]; then
    if ! command -v brew >/dev/null 2>&1; then
      echo "Homebrew is required: https://brew.sh" >&2
      exit 1
    fi
    brew bundle --file "$REPO_ROOT/Brewfile"
  else
    echo "Non-macOS system: install tmux, Vim, yazi, Node.js, npm, and git with your package manager."
  fi

  if command -v npm >/dev/null 2>&1 && ! command -v pi >/dev/null 2>&1; then
    npm install -g --ignore-scripts @earendil-works/pi-coding-agent
  fi
}

backup_and_link() {
  local source=$1 target=$2 relative

  mkdir -p "$(dirname "$target")"
  if [[ -L $target && $(readlink "$target") == "$source" ]]; then
    printf 'ok    %s\n' "$target"
    return
  fi

  if [[ -e $target || -L $target ]]; then
    relative=${target#"$HOME"/}
    mkdir -p "$BACKUP_ROOT/$(dirname "$relative")"
    mv "$target" "$BACKUP_ROOT/$relative"
    printf 'save  %s -> %s\n' "$target" "$BACKUP_ROOT/$relative"
  fi

  ln -s "$source" "$target"
  printf 'link  %s -> %s\n' "$target" "$source"
}

link_configs() {
  backup_and_link "$REPO_ROOT/config/tmux/root.conf" "$HOME/.tmux.conf"
  backup_and_link "$REPO_ROOT/config/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"
  backup_and_link "$REPO_ROOT/config/tmux/layouts.zsh" "$HOME/.config/tmux/layouts.zsh"

  backup_and_link "$REPO_ROOT/config/vim/vimrc" "$HOME/.vimrc"
  backup_and_link "$REPO_ROOT/config/vim/colors/ayu2.vim" "$HOME/.vim/colors/ayu2.vim"
  backup_and_link "$REPO_ROOT/config/vim/autoload/airline/themes/ayu2.vim" \
    "$HOME/.vim/autoload/airline/themes/ayu2.vim"
  mkdir -p "$HOME/.vim/undodir"

  for file in yazi.toml keymap.toml theme.toml open-in-vim.sh; do
    backup_and_link "$REPO_ROOT/config/yazi/$file" "$HOME/.config/yazi/$file"
  done

  backup_and_link "$REPO_ROOT/config/pi/settings.json" "$HOME/.pi/agent/settings.json"
  backup_and_link "$REPO_ROOT/config/pi/models.json" "$HOME/.pi/agent/models.json"
  backup_and_link "$REPO_ROOT/config/pi/themes/ayu.json" "$HOME/.pi/agent/themes/ayu.json"
}

configure_zsh() {
  local zshrc="$HOME/.zshrc" marker='# >>> yapi >>>'
  touch "$zshrc"
  if ! grep -Fq "$marker" "$zshrc"; then
    cat >> "$zshrc" <<'EOF'

# >>> yapi >>>
export EDITOR=vim
export VISUAL=vim
source "$HOME/.config/tmux/layouts.zsh"
# <<< yapi <<<
EOF
    printf 'edit  added yapi block to %s\n' "$zshrc"
  else
    printf 'ok    yapi block already present in %s\n' "$zshrc"
  fi
}

install_plugins() {
  if ! command -v git >/dev/null 2>&1; then
    echo "git is required to install plugins" >&2
    return 1
  fi

  if [[ ! -d $HOME/.tmux/plugins/tpm/.git ]]; then
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
  fi
  "$HOME/.tmux/plugins/tpm/bin/install_plugins" || true

  if [[ ! -d $HOME/.vim/bundle/Vundle.vim/.git ]]; then
    git clone --depth=1 https://github.com/VundleVim/Vundle.vim.git \
      "$HOME/.vim/bundle/Vundle.vim"
  fi
  if command -v vim >/dev/null 2>&1; then
    vim +PluginInstall +qall
  fi
}

((INSTALL_PACKAGES)) && install_packages
link_configs
configure_zsh
((INSTALL_PLUGINS)) && install_plugins

echo
echo "yapi setup complete."
echo "Restart yazi and pi; restart tmux fully for extended-key changes."
if [[ -d $BACKUP_ROOT ]]; then
  echo "Backups: $BACKUP_ROOT"
fi
