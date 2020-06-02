#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# fish
mkdir -p $HOME/.config/fish
ln -si $DIR/.config/fish/config.fish $HOME/.config/fish/config.fish 
ln -si $DIR/.config/fish/functions $HOME/.config/fish/functions

echo "Login/logout to finalize installation"
