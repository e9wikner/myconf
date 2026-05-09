#!/bin/bash
set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

if ! command -v pacman >/dev/null 2>&1; then
    echo "This installer is intended for Arch/Omarchy systems with pacman."
    exit 1
fi

sudo pacman -S --needed \
    fish \
    tmux

mkdir -p "$XDG_CONFIG_HOME"

ln -si "$DIR/.tmux.conf" "$HOME/.tmux.conf"
ln -si "$DIR/.rgrc" "$HOME/.rgrc"

# fish
mkdir -p "$XDG_CONFIG_HOME/fish/conf.d"
ln -si "$DIR/.config/fish/config.fish" "$XDG_CONFIG_HOME/fish/conf.d/myconf.fish"
[ -d "$XDG_CONFIG_HOME/fish/functions" ] && mv "$XDG_CONFIG_HOME/fish/functions" "$XDG_CONFIG_HOME/fish/functions.bak"
ln -si "$DIR/.config/fish/functions" "$XDG_CONFIG_HOME/fish/functions"
