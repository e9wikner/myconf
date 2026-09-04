#!/usr/bin/env bash
set -euo pipefail

# Arch Linux dotfile installer for myconf. Symlinks only — no sudo, no
# pacman. Packages are someone else's job: on hubbabubba, ansible installs
# everything in packages.arch and then runs this script as the dev user.
#
# Unlike install-mac.sh there is no OS gate: this script only creates links
# in $HOME, which is harmless anywhere, and being platform-agnostic keeps it
# testable on any machine with a throwaway HOME.
#
# fish is the login shell here (not zsh), so this links the fish config into
# conf.d/ instead of .zshrc. No alacritty, no fonts — the laptop terminal
# renders those.

# ── Options ───────────────────────────────────────────────
DRY_RUN=false
if [[ "${1:-}" == "--dry-run" || "${1:-}" == "-n" ]]; then
    DRY_RUN=true
fi

# ── Constants ──────────────────────────────────────────────
MYCONF_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.myconf_backup/$(date +%Y%m%d_%H%M%S)"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

# ── Helpers ────────────────────────────────────────────────

info()    { echo "[INFO] $1"; }
warn()    { echo "[WARN] $1"; }
success() { echo "[OK] $1"; }
dry()     { echo "[DRY-RUN] $*"; }

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

if $DRY_RUN; then
    info "myconf Arch installer (dry run)"
else
    info "myconf Arch installer"
fi
info "Repository: $MYCONF_DIR"
echo ""

# ── Symlinks ──────────────────────────────────────────────

info "Creating symlinks..."

# fish reads everything in conf.d/ automatically, so the myconf config goes
# there under its own name (same pattern as install-ubuntu.sh).
backup_and_link "$MYCONF_DIR/.config/fish/config.fish"  "$XDG_CONFIG_HOME/fish/conf.d/myconf.fish"
backup_and_link "$MYCONF_DIR/.config/fish/functions"    "$XDG_CONFIG_HOME/fish/functions"
backup_and_link "$MYCONF_DIR/.tmux.conf"                "$HOME/.tmux.conf"
backup_and_link "$MYCONF_DIR/.rgrc"                     "$HOME/.rgrc"

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

    # HTTPS on purpose: the server user has no GitHub SSH key at first apply
    # (docs/dev.md in hubbabubba covers creating one later).
    run git clone https://github.com/e9wikner/astronvim-config.git "$XDG_CONFIG_HOME/nvim"
    $DRY_RUN || success "Neovim config cloned"
fi

echo ""

# ── Done ──────────────────────────────────────────────────

if $DRY_RUN; then
    success "Dry run complete. No changes were made."
else
    success "Installation complete!"
    if [[ -d "$BACKUP_DIR" ]]; then
        warn "Backups saved to: $BACKUP_DIR"
    fi
fi
