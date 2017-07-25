export PATH=/usr/sbin:/usr/local/sbin:/usr/local/bin:$PATH:/sbin:

# ----------------------------
# ALIAS
# ----------------------------
alias brewup='brew update; brew upgrade; brew prune; brew cleanup; brew doctor'
alias weather='ansiweather -l Seattle,WA -u imperial'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias qfind="find . -name "
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias c='clear'
alias hclear='history -c; clear'
alias ll='ls -laGFh'
#alias ll='ls -laG'
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

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# ----------------------------
# FUNCTIONS
# ----------------------------

# get current branch in git repo
function parse_git_branch() {
    BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    if [ ! "${BRANCH}" == "" ]
    then
	STAT=`parse_git_dirty`
	echo "[${BRANCH}${STAT}]"
    else
	echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=`git status 2>&1 | tee`
    dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
    untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
    ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
    newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
    renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
    deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
    bits=''
    if [ "${renamed}" == "0" ]; then
	bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
	bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
	bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
	bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
	bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
	bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
	echo " ${bits}"
    else
	echo ""
    fi
}

# ----------------------------
# ENV VARIABLES
# ----------------------------
export HISTSIZE=5000
export EDITOR=vim
export BLOCKSIZE=1K
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

export GOPATH=$HOME/go

if [ $(id -u) -eq 0 ];
then
    export PS1="\[\e[41m\]\u\[\e[m\]@\h \W# "
else
    export PS1="\u@\h ./\W\`parse_git_branch\`\\$ "
fi
