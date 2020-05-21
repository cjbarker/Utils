#!/usr/bin/env bash

# ###############################################################
# Automates Repository Mirror from GitLab to GitHub
#
# Handles creating remote repo, settings up mirroring & activation.
#
# Usage: ./git-lab2hub.sh [access-gh_token-file-name] [access-gl-token-file-name]
#        access-gh_token-file-name: access token for GitHub
#        access-gl_token-file-name: access token for GitLab
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
CMDS[4]='jq'

function echoerr {
    echo "$@" 1>&2
}

function usage() {
    echo -e "Usage: $0 [repo-name] [access-gh_token-file-name] [access-gl token-file-name]"
    echo -e "\trepo-name: name of repository to mirror"
    echo -e "\taccess-gh_token-file-name: access token for GitHub"
    echo -e "\taccess-gl_token-file-name: access token for GitLab"
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
[[ $# -ne 3 ]] && usage

if [ -z "${1}" ]; then
    echoerr "Invalid repo name - cannot be null."
    exit 2
fi

if [ ! -f "${2}" ]; then
    echoerr "Invalid file for GitHub access token: ${2}"
    exit 3
fi
if [ ! -f "${3}" ]; then
    echoerr "Invalid file for GitLab access token: ${3}"
    exit 4
fi

repo=`echo ${1} | sed "s/.git//g"`
gh_token=`cat ${2}`
gl_token=`cat ${3}`
username="cjbarker" # TODO take cmdline arg
url="https://${username}:${gh_token}@github.com/${username}/${repo}.git"

#echo ${repo}
#echo ${gh_token}
#echo ${gl_token}
#echo ${url}

if [ ! -d "${repo}" ]; then
    mkdir -p ${repo}
fi

# create GH repo via API
curl -u "${username}:${gh_token}" https://api.github.com/user/repos -d "{\"name\":\"${repo}\"}"

# create actual repo
cd ${repo}
git init
touch .gitignore
git add .gitignore
git commit -m "Initial creation via ${0}"
git remote add origin "${url}"
git push -u origin master
cd ..
rm -rf ${repo}

# get GitLab Project ID
projectId=`curl -s https://gitlab.com/api/v4/users/${username}/projects | jq -r '.[] | .id, .name' | grep -B 1 "${repo}" | grep -v "${repo}"`

if [ -z "${projectId}" ]; then
    echoerr "Unable to find GitLab project id for repo ${repo}"
    exit 5
fi

#echo "Project ID: ${projectId}"

# Create a Remote Mirror in GitLab Project to GitHub
curl --request POST --data "url=https://${username}:${gh_token}@github.com/${username}/${repo}.git&enabled=true" --header "PRIVATE-TOKEN:${gl_token}" "https://gitlab.com/api/v4/projects/${projectId}/remote_mirrors"

exit 0
