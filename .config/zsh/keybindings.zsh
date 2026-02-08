# Vi mode and key bindings

bindkey -v
export KEYTIMEOUT=1

# Keep useful emacs bindings in vi insert mode
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^W' backward-kill-word

# History search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^P' up-history
bindkey '^N' down-history

# fzf integration (Homebrew)
if [[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/key-bindings.zsh" ]]; then
    source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/key-bindings.zsh"
fi
if [[ -f "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/completion.zsh" ]]; then
    source "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell/completion.zsh"
fi
