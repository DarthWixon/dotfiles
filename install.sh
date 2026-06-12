#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log()  { echo -e "${GREEN}==>${NC} $1"; }
warn() { echo -e "${YELLOW}warn:${NC} $1"; }

link() {
    local src="$DOTFILES/$1"
    local dst="$2"

    mkdir -p "$(dirname "$dst")"

    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        warn "$dst already exists — backing up to $dst.bak"
        mv "$dst" "$dst.bak"
    fi

    ln -s "$src" "$dst"
    log "linked $1 → $dst"
}

OS=$(uname)

# Shared — all machines
link shared/kitty ~/.config/kitty
link shared/zsh/.zshrc ~/.zshrc

if [ "$OS" = "Linux" ]; then
    link linux/i3 ~/.config/i3
    link linux/polybar ~/.config/polybar
    link linux/picom ~/.config/picom

elif [ "$OS" = "Darwin" ]; then
    PROFILE="${DOTFILES_PROFILE:-}"

    if [ -z "$PROFILE" ]; then
        echo "macOS detected. Profile? (personal/work)"
        read -r PROFILE
    fi

    if [ "$PROFILE" = "personal" ]; then
        link macos/personal/yabai ~/.config/yabai
        chmod +x "$DOTFILES/macos/personal/yabai/yabairc"
        link macos/personal/skhd ~/.config/skhd
    elif [ "$PROFILE" = "work" ]; then
        log "Work profile — shared configs only."
    else
        warn "Unknown profile '$PROFILE', skipping macOS-specific configs."
    fi

else
    warn "Unrecognised OS '$OS' — only shared configs linked."
fi

log "Done."
