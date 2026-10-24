#!/usr/bin/env bash
set -euo pipefail

BIN_TARGET="$HOME/.local/bin/scripts"
FISH_COMPLETION="$HOME/.config/fish/completions/scripts.fish"
BASH_COMPLETION="$HOME/.local/share/bash-completion/completions/scripts"
ZSH_COMPLETION="$HOME/.zsh/completion/_scripts"

COLOR_GREEN="\033[1;32m"
COLOR_CYAN="\033[1;36m"
COLOR_RESET="\033[0m"

log_info() { echo -e "${COLOR_CYAN}==>${COLOR_RESET} $1"; }
log_success() { echo -e "${COLOR_GREEN}==>${COLOR_RESET} $1"; }

log_info "Removing Script-Manager files..."

removed=0
targets=(
    "$BIN_TARGET"
    "$FISH_COMPLETION"
    "$BASH_COMPLETION"
    "$ZSH_COMPLETION"
)

for target in "${targets[@]}"; do
    if [[ -f "$target" ]]; then
        rm -f "$target"
        echo "  - Removed: $target"
        ((removed += 1))
    fi
done

if [[ "$removed" -eq 0 ]]; then
    echo "  (No installed files found to remove)"
else
    log_success "Uninstall completed. Removed $removed file(s)."
fi
log_info "Removing Script-Manager files..."

removed=0
targets=(
    "$BIN_TARGET"
    "$FISH_COMPLETION"
    "$BASH_COMPLETION"
    "$ZSH_COMPLETION"
)

for target in "${targets[@]}"; do
    if [[ -f "$target" ]]; then
        rm -f "$target"
        echo "  - Removed: $target"
        ((removed += 1))
    fi
done

if [[ "$removed" -eq 0 ]]; then
    echo "  (No installed files found to remove)"
else
    log_success "Uninstall completed. Removed $removed file(s)."
fi
