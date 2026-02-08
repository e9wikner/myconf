# Environment variables and PATH

export VISUAL=nvim
export EDITOR="$VISUAL"
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Homebrew (Apple Silicon vs Intel)
if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

# Local bin
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
