# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory extendedglob
bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/e9wikner/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Set vim as standard editor
export VISUAL=vim
export EDITOR="$VISUAL"

# VirtualenvWrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Devel
source /usr/bin/virtualenvwrapper.sh
