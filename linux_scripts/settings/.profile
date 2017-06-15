export PATH=/usr/sbin:/usr/local/sbin:$PATH:/sbin:

# ----------------------------
# ALIAS
# ----------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias qfind="find . -name "
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias c='clear'
alias hclear='history -c; clear'
alias ll='ls -laG'
alias vi='vim'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias ip='/sbin/ifconfig'
alias tidy_xml='tidy -utf8 -xml -w 255 -i -c -q -asxml'
alias df='df -h'
alias du='du -ch'
alias diskspace="du -S | sort -n -r |more"
alias chomp="tr -d'\n'"
alias grep='grep --color=auto'
alias ping='ping -c 5'
alias reboot='sudo /sbin/reboot'
alias shutdown='sudo /sbin/shutdown -t now'
alias prettyjson='python -m json.tool'
alias db_mysql='mysql -h localhost -u root'

# ----------------------------
# ENV VARIABLES
# ----------------------------
export HISTSIZE=5000
export EDITOR=vim
export BLOCKSIZE=1K
