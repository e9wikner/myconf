# Prompt with git branch via built-in vcs_info

autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats ' %F{magenta}(%b)%f'
zstyle ':vcs_info:*' enable git

setopt PROMPT_SUBST

PROMPT='%F{green}%n@%m%f %F{yellow}%~%f${vcs_info_msg_0_}
%# '
