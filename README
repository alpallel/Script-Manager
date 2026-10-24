# Scripts Manager

A CLI script manager for custom shell scripts with automatic discovery, case insensitive execution, and tab completions for **Bash**, **Fish**, and **Zsh**.

## Quick Install

Run directly via `curl`:

```bash
curl -fsSL https://raw.githubusercontent.com/alpallel/Scripts-Manager/main/install.sh | bash
```

Or clone and install locally:

```bash
git clone https://github.com/alpallel/Scripts-Manager.git
cd scripts-manager
./install.sh
```

## Configuration

By default, scripts are loaded from `~/scripts`. To customize this location, set `SCRIPTS_DIR` in your shell configuration:

```fish
# Fish (~/.config/fish/config.fish)
set -Ux SCRIPTS_DIR "$HOME/dotfiles/scripts"
```

```bash
# Bash (~/.bashrc)
export SCRIPTS_DIR="$HOME/dotfiles/scripts"
```

```zsh
# Zsh (~/.zshrc)
export SCRIPTS_DIR="$HOME/dotfiles/scripts"
```

### Zsh Completions Setup

If using Zsh, ensure your `~/.zshrc` has the completion directory added to `fpath` before `compinit`:

```zsh
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit
```

## Usage

| Command | Action |
|---|---|
| `scripts` | List all available scripts with descriptions |
| `scripts <name> [args...]` | Run script (case-insensitive, `.sh` suffix optional) |
| `scripts update` | Make all `.sh` files in the directory executable |
| `scripts new <name> [desc]` | Create a new executable script from template and open in `$EDITOR` |
| `scripts edit <name>` | Open script in `$EDITOR` (or `$VISUAL` / `nano` / `vi`) |
| `scripts path <name>` | Print the absolute path to a script |
| `scripts help` | Show usage and available commands |

### Script Descriptions

To attach inline descriptions in the listing and tab completions, add a comment in your script (case-insensitive):

```bash
#!/usr/bin/env bash
# Description: Connect to university campus SSO captive portal
```

## Uninstallation

To uninstall `scripts` and remove all installed shell completions:

```bash
./uninstall.sh
```

