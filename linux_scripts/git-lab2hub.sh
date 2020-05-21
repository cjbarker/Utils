#!/usr/bin/env bash

# ###############################################################
# Automates Repository Mirror from GitLab to GitHub
#
# Handles creating remote repo, settings up mirroring & activation.
#
# Usage: ./git-lab2hub.sh [access-token-file-name]
#        access-token-file-name: access token for GitHub
#
#  echo $?
#
# Exit return code == 0 then successful
# Exit return code != 0 then failed
#
# ###############################################################

# Required built-ins
declare -a CMDS
CMDS[0]='git'

function echoerr {
    echo "$@" 1>&2
}

function usage() {
    echo -e "Usage: $0 [repo-name] [access-token-file-name]"
    echo -e "\trepo-name: name of repository to mirror"
    echo -e "\taccess-token-file-name: access token for GitHub"
    exit 1
}

function cmd_exists {
    local cmd=$1
    local result=`which $cmd`

    if [ -n "$result" ]; then
        echo 0
    else
        echoerr "Command ${1} does not exist. Unable to execute script."
        echo 1
    fi
}

# *************************************************************
# M A I N     L O G I C
# *************************************************************

# validate binaries
for cmd in "${CMDS[@]}"
do
    #echo ${cmd}
    rc=`cmd_exists ${cmd}`
    if [ "$rc" -ne "0" ]; then
        exit $rc
    fi
done

# call usage() function if filename not supplied
[[ $# -eq 0 ]] && usage
[[ $# -ne 2 ]] && usage

if [ -z "${1}" ]; then
    echoerr "Invalid repo name - cannot be null."
    exit 2
fi

if [ ! -f "${2}" ]; then
    echoerr "Invalid file for access token: ${2}"
    exit 3
fi

repo=`cat ${1} | sed "s/.git//g"`
token=`cat ${2}`

# create GH repo
#echo ${repo}
#echo ${token}

