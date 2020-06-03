function ga() { git add "$@" ;}
function gb() { git branch "$@" ;}
function gc() { git commit "$@" ;}
function gch() { git checkout "$@" ;}
function gd() { git diff "$@" ;}
function gf() { git fetch "$@" ;}
function gp() { git pull "$@" ;}
function gs() { git status "$@" ;}

function gstash() { git stash "$@" ;}
function gpop() { git stash pop "$@" ;}

export EDITOR=vim
set -o vi
