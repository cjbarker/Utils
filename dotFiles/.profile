export PATH=/usr/sbin:/usr/local/sbin:/usr/local/bin:$PATH:/sbin:

if [ -f .bash_aliases ]; then
    source .bash_aliases
fi

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

# colorize man page
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#export M2_HOME=/usr/local/Cellar/maven/3.5.0/
export PATH=$M2:$PATH
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

export ANDROID_HOME=/usr/local/share/android-sdk/

#export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
export JAVA_14_HOME=$(/usr/libexec/java_home -v14)

#alias java8='export JAVA_HOME=$JAVA_8_HOME; export PATH=$JAVA_HOME/bin:$PATH'
alias java14='export JAVA_HOME=$JAVA_14_HOME; export PATH=$JAVA_HOME/bin:$PATH'

#default java14
java14

# disable shell warning when not using ZSH on Mac
export BASH_SILENCE_DEPRECATION_WARNING=1

if [ $(id -u) -eq 0 ];
then
    export PS1="\[\e[41m\]\u\[\e[m\]@\h \W# "
else
    export PS1="\u@\h ./\W\`parse_git_branch\`\\$ "
fi
