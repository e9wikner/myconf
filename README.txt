Run install_in_[your_shell].sh from this dir

# On mac

brew install neovim ripgrep

# On Ubuntu

sudo apt-get install neovim ripgrep

# Windows:

- Create AppData/Local/alacritty/alacritty.toml with:

    import = ["C:/Users/swikner1/dev/myconf/alacritty/alacritty.toml",]
    working_directory = "C:/Users/swikner1/dev"

- In Powershell as admin:

    New-Item -ItemType SymbolicLink -Path .config\alacritty -Value .\dev\myconf\alacritty
