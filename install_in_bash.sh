#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

bash $DIR/install.sh
ln -si $DIR/.bash_aliases $HOME/.bash_aliases

echo "Login/logout to finalize installation"
