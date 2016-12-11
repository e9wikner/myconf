set arken_ip ~/Sync/arken_ip.txt

if [ -f $arken_ip ]
    set -x ARKEN (cat $arken_ip)
end

# Set vim as standard editor
set -x VISUAL vim
set -x EDITOR "$VISUAL"

#set -gx WORKON_HOME $HOME/.virtual-environments/
# . ~/.config/fish/workon_funcs.fish

fish_vi_key_bindings
