Run install_in_[your_shell].sh from this dir

Some tools: https://www.josean.com/posts/7-amazing-cli-tools

# On mac

brew install neovim ripgrep fzf tmux

# On Ubuntu

sudo apt-get install neovim ripgrep fzf

# Windows:

- Create AppData/Local/alacritty/alacritty.toml with:

    import = ["C:/Users/swikner1/dev/myconf/alacritty/alacritty.toml",]
    working_directory = "C:/Users/swikner1/dev"

- In Powershell as admin:

    New-Item -ItemType SymbolicLink -Path .config\alacritty -Value .\dev\myconf\alacritty

# Alacritty

To find more themes: https://github.com/alacritty/alacritty-theme
