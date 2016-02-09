#!/usr/bin/sh

# ZSH
ln -sr .zshrc $HOME/.zshrc
echo "Login/logout or source ~/.zshrc"

# VIM
ln -sr .vimrc $HOME/.vimrc
# pathogen, https://github.com/tpope/vim-pathogen
mkdir -p $HOME/.vim/autoload $HOME/.vim/bundle
curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

