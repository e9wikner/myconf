#!/usr/bin/env zsh
set -euo pipefail

# ── Options ───────────────────────────────────────────────
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" || "${1:-}" == "-n" ]]; then
    DRY_RUN=true
fi

# ── Constants ──────────────────────────────────────────────
MYCONF_DIR="${0:A:h}"
BACKUP_DIR="$HOME/.myconf_backup/$(date +%Y%m%d_%H%M%S)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ── Helpers ────────────────────────────────────────────────

info()    { print -P "%F{blue}[INFO]%f $1" }
warn()    { print -P "%F{yellow}[WARN]%f $1" }
error()   { print -P "%F{red}[ERROR]%f $1" }
success() { print -P "%F{green}[OK]%f $1" }
dry()     { print -P "%F{cyan}[DRY-RUN]%f $*" }

# Run a command, or print it in dry-run mode
run() {
    if $DRY_RUN; then
        dry "$*"
    else
        "$@"
    fi
}

backup_and_link() {
    local src="$1" dst="$2"
    local dst_dir="$(dirname "$dst")"

    if [[ -e "$dst" || -L "$dst" ]]; then
        if [[ "$(readlink "$dst" 2>/dev/null)" == "$src" ]]; then
            success "Already linked: $dst"
            return 0
        fi
        run mkdir -p "$BACKUP_DIR"
        run mv "$dst" "$BACKUP_DIR/$(basename "$dst")"
        $DRY_RUN || warn "Backed up: $dst -> $BACKUP_DIR/"
    fi

    [[ -d "$dst_dir" ]] || run mkdir -p "$dst_dir"
    run ln -s "$src" "$dst"
    $DRY_RUN || success "Linked: $dst -> $src"
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

BREW_PREFIX="$(brew --prefix)"

if $DRY_RUN; then
    info "myconf macOS installer (dry run)"
else
    info "myconf macOS installer"
fi
info "Repository: $MYCONF_DIR"
echo ""

# ── Packages ───────────────────────────────────────────────

info "Installing packages..."

packages=(neovim ripgrep fzf tmux lazygit node)
for pkg in "${packages[@]}"; do
    if [[ -d "$BREW_PREFIX/Cellar/$pkg" ]]; then
        success "Already installed: $pkg"
    else
        run brew install "$pkg"
    fi
done

casks=(alacritty font-code-new-roman-nerd-font)
for cask in "${casks[@]}"; do
    if [[ -d "$BREW_PREFIX/Caskroom/$cask" ]]; then
        success "Already installed: $cask (cask)"
    else
        run brew install --cask "$cask"
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
            run mkdir -p "$BACKUP_DIR"
            run mv "$nvim_dir" "$BACKUP_DIR/$(basename "$nvim_dir")"
            $DRY_RUN || warn "Backed up: $nvim_dir"
        fi
    done

    run git clone git@github.com:e9wikner/astronvim-config.git "$XDG_CONFIG_HOME/nvim"
    $DRY_RUN || success "Neovim config cloned"
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

if $DRY_RUN; then
    success "Dry run complete. No changes were made."
else
    success "Installation complete!"
    if [[ -d "$BACKUP_DIR" ]]; then
        warn "Backups saved to: $BACKUP_DIR"
    fi
    info "Restart your shell or run: source ~/.zshrc"
fi
