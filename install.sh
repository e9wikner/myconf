#!/bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ZSH
# ln -si $DIR/.zshrc $HOME/.zshrc

# VIM
ln -si $DIR/.vimrc $HOME/.vimrc
# pathogen, https://github.com/tpope/vim-pathogen
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

echo "Login/logout to finalize installation"
