# yapi

A reproducible terminal development workspace built around **yazi + Vim + tmux + pi**.

The default `tdl pi` layout gives each tool a dedicated tmux pane:

```text
┌──────────┬──────────────────────────┬──────────────┐
│          │                          │              │
│  yazi    │           Vim            │      pi      │
│          │                          │              │
│          ├──────────────────────────┤              │
│          │         terminal         │              │
└──────────┴──────────────────────────┴──────────────┘
```

Pressing `o` or `O` in yazi opens the selected file in the existing Vim pane and focuses it instead of launching another Vim over the file manager.

## Included

- tmux keybindings, true-color support, extended keys for pi, Ayu borders, and TPM plugins
- `tdl`, `tdlm`, `tds`, and `tsl` zsh layout helpers
- Vim configuration managed by Vundle, with custom Ayu and airline themes
- yazi's narrow-pane layout, Ayu theme, and tmux-aware Vim opener
- pi settings, OpenRouter model metadata, and matching Ayu theme
- idempotent install and validation scripts

Machine state and credentials are deliberately excluded: Pi auth, project trust, sessions, caches, API keys, Vim undo/session files, and installed plugin trees.

## Requirements

Primary setup is macOS with [Homebrew](https://brew.sh/) and zsh. The configurations themselves are usable on Linux if the dependencies are installed separately.

- tmux 3.5+ (for CSI-u extended keys)
- Vim 9+
- yazi
- Node.js and npm
- [pi coding agent](https://pi.dev/)
- git

Versions used when this repository was created: tmux 3.7c, Vim 9.2, yazi 26.8.15, Node.js 26.7.0, and pi 0.84.3.

## Install

```sh
git clone https://github.com/YOUR_USER/yapi.git ~/projects/yapi
cd ~/projects/yapi
./scripts/install.sh
```

The installer:

1. installs Homebrew packages from `Brewfile` on macOS;
2. installs pi through npm if it is missing;
3. backs up existing target files under `~/.local/state/yapi/backups/`;
4. symlinks the tracked configurations into their standard locations;
5. adds a small yapi block to `~/.zshrc`;
6. installs TPM and Vundle plugins.

For an already provisioned machine:

```sh
./scripts/install.sh --link-only
```

To install packages and links but skip editor/tmux plugins:

```sh
./scripts/install.sh --no-plugins
```

Restart yazi and pi after installation. Restart the tmux server to apply extended-key settings:

```sh
tmux kill-server
tmux
```

> `tmux kill-server` closes every running tmux session. Save work first.

## Use

From a project directory, start tmux and create the development layout:

```sh
tmux
tdl pi
```

You may substitute any shell command for `pi`, and optionally provide a second agent:

```sh
tdl pi codex
```

Other helpers:

- `tdlm pi` — create one `tdl` window for each immediate subdirectory
- `tds` — four-pane Vim/diff/terminal/opencode layout (requires `hunk` and `opencode`)
- `tsl 4 pi` — tiled swarm running the same command in four panes

### yazi → Vim

In yazi, hover or select files and press `o` or `O`. `config/yazi/open-in-vim.sh` finds `vim` or `nvim` in the current tmux window, sends `:edit` for every selected path, and focuses that pane. If no editor pane exists, it falls back to launching Vim normally.

### Pi authentication

Authentication is intentionally not stored in this repository. After a fresh install, use:

```text
pi
/login
```

Alternatively, provide a supported API-key environment variable from a private password manager or untracked shell file. Never commit `~/.pi/agent/auth.json`, `.env` files, or API keys.

The tracked Pi files map to:

```text
config/pi/settings.json   -> ~/.pi/agent/settings.json
config/pi/models.json     -> ~/.pi/agent/models.json
config/pi/themes/ayu.json -> ~/.pi/agent/themes/ayu.json
```

## Customize

The installer uses symlinks, so editing a live config edits this repository directly. Validate and commit changes with:

```sh
./scripts/check.sh
git status
git add -A
git commit
```

Reload individual tools where possible:

- tmux: `Ctrl-Space q`
- pi: `/reload`
- yazi: restart yazi
- Vim: restart Vim or source `~/.vimrc`

## Security

Run `./scripts/check.sh` before publishing. It validates shell, JSON, TOML, Vim, and tmux configuration and scans tracked files for common private-key/API-key patterns. The scan is a guardrail, not a substitute for reviewing `git diff --cached`.

## License

GPL-3.0-only. See [LICENSE](LICENSE). The custom Vim Ayu port retains its upstream GPL-3.0 licensing notice.
