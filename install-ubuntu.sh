#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install -y \
    fish \
    fzf \
    git \
    ripgrep \
    tmux \

ln -si $DIR/.config/alacritty $HOME/.config/alacritty
ln -si $DIR/.tmux.conf $HOME/.tmux.conf
ln -si $DIR/.rgrc $HOME/.rgrc

# fish
mkdir -p $HOME/.config/fish
ln -si $DIR/.config/fish/config.fish $HOME/.config/fish/conf.d/myconf.fish 
[ -d "$HOME/.config/fish/functions" ] && mv "$HOME/.config/fish/functions" "$HOME/.config/fish/functions.bak"
ln -si $DIR/.config/fish/functions $HOME/.config/fish/functions

# AstroNvim
sudo snap install nvim --classic
[ -d "$HOME/.config/nvim" ] && mv "$HOME/.config/nvim" "$HOME/.config/nvim.bak"
[ -d "$HOME/.local/share/nvim" ] && mv "$HOME/.local/share/nvim" "$HOME/.local/share/nvim.bak"
[ -d "$HOME/.local/state/nvim" ] && mv "$HOME/.local/state/nvim" "$HOME/.local/state/nvim.bak"
[ -d "$HOME/.cache/nvim" ] && mv "$HOME/.cache/nvim" "$HOME/.cache/nvim.bak"
git clone git@github.com:e9wikner/astronvim-config.git ~/.config/nvim

# lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
lazygit --version

# Copilot
cd ~
curl -sL https://deb.nodesource.com/setup_20.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt install nodejs
