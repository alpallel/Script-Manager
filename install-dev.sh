#!/usr/bin/env bash
set -euo pipefail

# Configuration (Defaults to dev branch)
REPO="${REPO:-alpallel/Script-Manager}"
BRANCH="${BRANCH:-dev}"
RAW_BASE="https://raw.githubusercontent.com/${REPO}/${BRANCH}"

if [[ -n "${BASH_SOURCE[0]:-}" && -f "${BASH_SOURCE[0]}" ]]; then
    PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
else
    PROJECT_ROOT=""
fi
BIN_DIR="${HOME}/.local/bin"
FISH_COMPLETION_DIR="${HOME}/.config/fish/completions"
BASH_COMPLETION_DIR="${HOME}/.local/share/bash-completion/completions"
ZSH_COMPLETION_DIR="${HOME}/.zsh/completion"

COLOR_GREEN="\033[1;32m"
COLOR_CYAN="\033[1;36m"
COLOR_YELLOW="\033[1;33m"
COLOR_RESET="\033[0m"

log_info() { echo -e "${COLOR_CYAN}==>${COLOR_RESET} $1"; }
log_success() { echo -e "${COLOR_GREEN}==>${COLOR_RESET} $1"; }
log_warn() { echo -e "${COLOR_YELLOW}==>${COLOR_RESET} $1"; }

mkdir -p "$BIN_DIR"

download_or_install() {
    local rel_path="$1"
    local dest_path="$2"
    local mode="${3:-644}"

    if [[ -n "$PROJECT_ROOT" && -f "$PROJECT_ROOT/$rel_path" ]]; then
        install -m "$mode" "$PROJECT_ROOT/$rel_path" "$dest_path"
    else
        if [[ "$REPO" == "username/scripts-manager" ]]; then
            echo "Error: Local file '$rel_path' not found and REPO is still set to placeholder 'username/scripts-manager'." >&2
            echo "Please set REPO=\"owner/repo\" or install from a cloned repository." >&2
            exit 1
        fi
        curl -fsSL "${RAW_BASE}/${rel_path}" -o "$dest_path"
        chmod "$mode" "$dest_path"
    fi
}

log_info "Installing Script-Manager (Development branch: ${BRANCH})..."

# 1. Install Manager Binary
log_info "Installing 'scripts' executable to $BIN_DIR..."
download_or_install "bin/scripts" "$BIN_DIR/scripts" 755
log_success "'scripts' binary installed to $BIN_DIR/scripts"

# 2. Install Shell Completions
log_info "Installing shell completions..."

# Fish completions
if command -v fish >/dev/null 2>&1 || [[ -d "$HOME/.config/fish" ]]; then
    mkdir -p "$FISH_COMPLETION_DIR"
    download_or_install "completions/scripts.fish" "$FISH_COMPLETION_DIR/scripts.fish" 644
    log_success "Fish completions installed to $FISH_COMPLETION_DIR/scripts.fish"
fi

# Bash completions
if command -v bash >/dev/null 2>&1 || [[ -d "$HOME/.local/share/bash-completion" ]] || [[ "${SHELL:-}" == *"bash"* ]]; then
    mkdir -p "$BASH_COMPLETION_DIR"
    download_or_install "completions/scripts.bash" "$BASH_COMPLETION_DIR/scripts" 644
    log_success "Bash completions installed to $BASH_COMPLETION_DIR/scripts"
fi

# Zsh completions
if command -v zsh >/dev/null 2>&1 || [[ -d "$HOME/.zsh" ]] || [[ "${SHELL:-}" == *"zsh"* ]]; then
    mkdir -p "$ZSH_COMPLETION_DIR"
    download_or_install "completions/_scripts" "$ZSH_COMPLETION_DIR/_scripts" 644
    log_success "Zsh completions installed to $ZSH_COMPLETION_DIR/_scripts"
fi

# 3. Path & Shell Verification
log_info "Verifying PATH configuration..."
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    log_warn "$BIN_DIR is not detected in your current PATH."
    echo ""
    echo "To add it permanently:"
    echo "  • Fish: Run 'fish_add_path ~/.local/bin'"
    echo "  • Bash: Add 'export PATH=\"\$HOME/.local/bin:\$PATH\"' to ~/.bashrc"
    echo "  • Zsh:  Add 'export PATH=\"\$HOME/.local/bin:\$PATH\"' to ~/.zshrc"
    echo ""
else
    log_success "PATH check passed ($BIN_DIR found)."
fi

if [[ -f "$ZSH_COMPLETION_DIR/_scripts" ]]; then
    echo "Tip for Zsh users: Ensure your ~/.zshrc includes:"
    echo "  fpath=(~/.zsh/completion \$fpath)"
    echo "  autoload -Uz compinit && compinit"
    echo ""
fi

log_success "Development installation complete! Try running 'scripts'."

