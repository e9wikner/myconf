#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sudo apt install \
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
ln -si $DIR/.config/fish/config.fish $HOME/.config/fish/config.fish 
ln -si $DIR/.config/fish/functions $HOME/.config/fish/functions

# AstroNvim
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
# git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
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
