# macOS-specific configuration

# SSH Keychain integration
# Requires ~/.ssh/config:
#   Host *
#     UseKeychain yes
#     AddKeysToAgent yes
#     IdentityFile ~/.ssh/id_ed25519
ssh-add --apple-use-keychain 2>/dev/null

# Use GNU ls colors if coreutils is installed
if command -v gls &>/dev/null; then
    alias ls='gls --color=auto'
fi
