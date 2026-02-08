#!/usr/bin/env zsh
set -euo pipefail

# ── Constants ──────────────────────────────────────────────
MYCONF_DIR="${0:A:h}"
BACKUP_DIR="$HOME/.myconf_backup/$(date +%Y%m%d_%H%M%S)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ── Helpers ────────────────────────────────────────────────

info()    { print -P "%F{blue}[INFO]%f $1" }
warn()    { print -P "%F{yellow}[WARN]%f $1" }
error()   { print -P "%F{red}[ERROR]%f $1" }
success() { print -P "%F{green}[OK]%f $1" }

backup_and_link() {
    local src="$1" dst="$2"

    if [[ -e "$dst" || -L "$dst" ]]; then
        if [[ "$(readlink "$dst" 2>/dev/null)" == "$src" ]]; then
            success "Already linked: $dst"
            return 0
        fi
        mkdir -p "$BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/$(basename "$dst")"
        warn "Backed up: $dst -> $BACKUP_DIR/"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    success "Linked: $dst -> $src"
}

# ── OS Check ───────────────────────────────────────────────

if [[ "$OSTYPE" != darwin* ]]; then
    error "This script is for macOS. Use install-ubuntu.sh for Linux."
    exit 1
fi

# ── Homebrew ───────────────────────────────────────────────

if ! command -v brew &>/dev/null; then
    error "Homebrew not found. Install it first:"
    error '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

info "myconf macOS installer"
info "Repository: $MYCONF_DIR"
echo ""

# ── Packages ───────────────────────────────────────────────

info "Installing packages..."

packages=(neovim ripgrep fzf tmux lazygit node)
for pkg in "${packages[@]}"; do
    if brew list "$pkg" &>/dev/null; then
        success "Already installed: $pkg"
    else
        info "Installing: $pkg"
        brew install "$pkg"
    fi
done

casks=(alacritty font-code-new-roman-nerd-font)
for cask in "${casks[@]}"; do
    if brew list --cask "$cask" &>/dev/null 2>&1; then
        success "Already installed: $cask (cask)"
    else
        info "Installing: $cask"
        brew install --cask "$cask"
    fi
done

echo ""

# ── Symlinks ──────────────────────────────────────────────

info "Creating symlinks..."

backup_and_link "$MYCONF_DIR/.zshrc"              "$HOME/.zshrc"
backup_and_link "$MYCONF_DIR/.config/alacritty"   "$XDG_CONFIG_HOME/alacritty"
backup_and_link "$MYCONF_DIR/.tmux.conf"          "$HOME/.tmux.conf"
backup_and_link "$MYCONF_DIR/.rgrc"               "$HOME/.rgrc"

echo ""

# ── Neovim ────────────────────────────────────────────────

info "Setting up Neovim..."

if [[ -d "$XDG_CONFIG_HOME/nvim/.git" ]]; then
    success "Neovim config already cloned"
else
    # Back up existing nvim directories
    for nvim_dir in "$XDG_CONFIG_HOME/nvim" "$HOME/.local/share/nvim" "$HOME/.local/state/nvim" "$HOME/.cache/nvim"; do
        if [[ -e "$nvim_dir" ]]; then
            mkdir -p "$BACKUP_DIR"
            mv "$nvim_dir" "$BACKUP_DIR/$(basename "$nvim_dir")"
            warn "Backed up: $nvim_dir"
        fi
    done

    info "Cloning astronvim-config..."
    git clone git@github.com:e9wikner/astronvim-config.git "$XDG_CONFIG_HOME/nvim"
    success "Neovim config cloned"
fi

echo ""

# ── SSH Advice ────────────────────────────────────────────

info "SSH Keychain setup (manual step):"
info "  Add to ~/.ssh/config:"
info "    Host *"
info "      UseKeychain yes"
info "      AddKeysToAgent yes"
info "      IdentityFile ~/.ssh/id_ed25519"

echo ""

# ── Done ──────────────────────────────────────────────────

success "Installation complete!"
if [[ -d "$BACKUP_DIR" ]]; then
    warn "Backups saved to: $BACKUP_DIR"
fi
info "Restart your shell or run: source ~/.zshrc"
