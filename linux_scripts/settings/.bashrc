# Configure command prompt
function _update_ps1() {
    PS1="$(~/powerline-shell.py $? 2> /dev/null)"
}

if [ -f ~/powerline-shell.py ]; then
    # setup via powerline
    if [ "$TERM" != "linux" ]; then
        PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
    fi
else
    # setup basic prompt
    if [ $(id -u) -eq 0 ]; then 
        # you are root, set red colour prompt
        PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w # \\[$(tput sgr0)\\]"
    else 
        # normal
        PS1="[\\u@\\h:\\w]$ "
    fi
fi

alias_file=~/.alias

if [ -f $alias_file ]; then
    source $alias_file
fi
