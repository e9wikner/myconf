#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# NeoVim
ln -si $DIR/.config/nvim/init.vim $HOME/.config/nvim/init.vim
## plug.vim plugin handler
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# VIM
ln -si $DIR/.vimrc $HOME/.vimrc
# pathogen, https://github.com/tpope/vim-pathogen
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Login/logout to finalize installation"
