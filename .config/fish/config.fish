# Set neovim as standard editor
set -gx VISUAL nvim
set -gx EDITOR "$VISUAL"
set -gx RIPGREP_CONFIG_PATH "$HOME/.rgrc"

if status is-interactive
    fish_vi_key_bindings

    if functions -q fzf_key_bindings
        fzf_key_bindings
    end
end
