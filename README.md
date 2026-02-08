# myconf

Personal dotfiles for macOS development — zsh, neovim, tmux, alacritty.

## Quick Start

```sh
git clone <repo-url> ~/Development/myconf
cd ~/Development/myconf
./install-mac.sh
```

Requires [Homebrew](https://brew.sh). The script will check for it and print install instructions if missing.

## What Gets Installed

### Packages (via Homebrew)

neovim, ripgrep, fzf, tmux, lazygit, node, alacritty, CodeNewRoman Nerd Font

### Symlinks

| Repo path            | Target                   |
|----------------------|--------------------------|
| `.zshrc`             | `~/.zshrc`               |
| `.config/alacritty/` | `~/.config/alacritty`    |
| `.tmux.conf`         | `~/.tmux.conf`           |
| `.rgrc`              | `~/.rgrc`                |

Neovim config is cloned separately from [astronvim-config](https://github.com/e9wikner/astronvim-config) into `~/.config/nvim`.

Existing files are backed up to `~/.myconf_backup/<timestamp>/` before linking.

## Zsh Configuration

The `.zshrc` entry point sources modular files from `.config/zsh/` in this order:

1. **environment.zsh** — PATH, EDITOR, Homebrew, locale
2. **history.zsh** — 50k lines, shared across sessions, dedup
3. **completion.zsh** — tab completion with daily cache, case-insensitive, menu select
4. **keybindings.zsh** — vi mode, fzf integration, Ctrl-R history search
5. **prompt.zsh** — minimal prompt with git branch (via built-in vcs_info)
6. **aliases.zsh** — git shortcuts, nvim aliases
7. **macos.zsh** — SSH Keychain, GNU ls colors (macOS only)

### Git Aliases

| Alias | Command                     |
|-------|-----------------------------|
| `ga`  | `git add`                   |
| `gb`  | `git branch`                |
| `gc`  | `git commit`                |
| `gd`  | `git diff`                  |
| `gf`  | `git fetch`                 |
| `gg`  | `lazygit`                   |
| `gl`  | `git log`                   |
| `glg` | `git log --graph --oneline` |
| `gp`  | `git pull`                  |
| `gr`  | `git rebase`                |
| `gri` | `git rebase -i`             |
| `grc` | `git rebase --continue`     |
| `gra` | `git rebase --abort`        |
| `gs`  | `git status`                |

## SSH Keychain Setup

Add to `~/.ssh/config`:

```
Host *
  UseKeychain yes
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519
```

This replaces manual ssh-agent management. macOS Keychain stores passphrases across reboots.

## Customization

Create `~/.zshrc.local` for machine-specific overrides (not tracked in git). This file is sourced at the end of `.zshrc` if it exists.

## Linux

The original Ubuntu install script is preserved as `install-ubuntu.sh`. It uses apt and installs fish shell instead of zsh.

## Legacy Files

The following files are kept in the repo for reference but are not used by the macOS installer:

- `.bash_aliases` — legacy bash git aliases
- `.vimrc` — legacy vim config (neovim is primary)
- `.config/fish/` — fish shell config (zsh is primary)
- `README.txt` — original documentation
