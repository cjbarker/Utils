if [ $(id -u) -eq 0 ]; then 
    # you are root, set red colour prompt
    PS1="\\[$(tput setaf 1)\\]\\u@\\h:\\w # \\[$(tput sgr0)\\]"
else # normal
    PS1="[\\u@\\h:\\w]$ "
fi

alias_file=~/.alias

if [ -f $alias_file ]; then
    source $alias_file
fi
