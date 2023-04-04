# Set vim as standard editor
set -Ux VISUAL nvim
set -Ux EDITOR "$VISUAL"
set -Ux RIPGREP_CONFIG_PATH "$HOME/.rgrc"
fish_vi_key_bindings
