set arken_ip ~/Sync/arken_ip.txt                                                
                                                                                
if [ -f $arken_ip ]                                                             
    set -x ARKEN (cat $arken_ip)                                                
end 

# Set vim as standard editor
set -x VISUAL vim
set -x EDITOR "$VISUAL"

# SSH agent
set SSHAGENT /usr/bin/ssh-agent
set SSHAGENTARGS "-s"
if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]
    eval $SSHAGENT $SSHAGENTARGS
    trap "kill $SSH_AGENT_PID" 0
end

