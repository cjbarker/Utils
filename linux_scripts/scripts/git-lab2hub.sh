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

function echoerr {
    echo "$@" 1>&2
}

function usage() {
    echo -e "Usage: $0 [access-token-file-name]"
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

# call usage() function if filename not supplied
[[ $# -eq 0 ]] && usage
[[ $# -ne 1 ]] && usage
