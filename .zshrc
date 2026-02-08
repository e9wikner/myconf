# myconf zsh configuration
# Resolve the directory this .zshrc lives in (follows symlinks)
MYCONF_ZSH="${${(%):-%x}:A:h}/.config/zsh"

source "$MYCONF_ZSH/environment.zsh"
source "$MYCONF_ZSH/history.zsh"
source "$MYCONF_ZSH/completion.zsh"
source "$MYCONF_ZSH/keybindings.zsh"
source "$MYCONF_ZSH/prompt.zsh"
source "$MYCONF_ZSH/aliases.zsh"
[[ "$OSTYPE" == darwin* ]] && source "$MYCONF_ZSH/macos.zsh"

# Machine-specific overrides (not tracked in git)
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
