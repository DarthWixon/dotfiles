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

if [ "$OS" != "Linux" ]; then
    warn "These dotfiles target Linux only — current OS is '$OS'. Aborting."
    exit 1
fi

link kitty   ~/.config/kitty
link .zshrc  ~/.zshrc
link i3      ~/.config/i3
link polybar ~/.config/polybar
link picom   ~/.config/picom

log "Done."
