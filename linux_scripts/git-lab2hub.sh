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
CMDS[1]='cat'
CMDS[2]='touch'
CMDS[3]='sed'

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

repo=`echo ${1} | sed "s/.git//g"`
token=`cat ${2}`
username="cjbarker" # TODO take cmdline arg
url="https://${username}:${token}@github.com/${username}/${repo}.git"

#echo ${repo}
#echo ${token}
#echo ${url}

if [ ! -d "${repo}" ]; then
    mkdir -p ${repo}
fi

# create GH repo via API
curl -u "${username}:${token}" https://api.github.com/user/repos -d "{\"name\":\"${repo}\"}"

# create actual repo
cd ${repo}
git init
touch .gitignore
git add .gitignore
git commit -m "Initial creation via ${0}"
git remote add origin "${url}"
git push -u origin master

# configure GL repo for push mirror to GH

exit 0
