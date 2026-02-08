# Zsh completion system

# Homebrew completions (must be before compinit)
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

autoload -Uz compinit

# Regenerate .zcompdump at most once per day
# -u: silently ignore insecure directories (common with Homebrew)
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -u
else
    compinit -C -u
fi

# Case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Menu selection with arrow keys
zstyle ':completion:*' menu select

# Colorized completion lists
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Group completions by type
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}-- %d --%f'

# Cache completions for speed
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zcompcache"

# Complete . and .. directories
zstyle ':completion:*' special-dirs true
