#!/bin/zsh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bash $DIR/install.sh
ln -si $DIR/.zshrc $HOME/.zshrc

