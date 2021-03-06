#!/bin/sh
# #####################################################
# Applies Git pre-commit hook to link appropriate file
# when applicable: Markdown, JavaScript, Go, Python,
# TypeScript.
#
# Output exit code and results from linter
#
# See Supported Linters: https://github.com/github/super-linter
# JavaScript = ESLint
# Markdown = mdl
# Python = pylint
# Go = golint
# JSON = jsonlint
# YAML = yamllint
# Bash = shellcheck
#
# #####################################################

declare -a TOOLS_TO_INSTALL

TOOLS_TO_INSTALL=(eslint mdl pylint golint jsonlint yamllint shellcheck)

function echoerr {
    echo "$@" 1>&2
}

function cmd_exists {
    local cmd=$1
    local result=$(which $cmd)

    if [ -n "$result" ]; then
        echo 0
    else
        #echoerr "Command ${1} does not exist. Unable to execute script."
        echo 1
    fi
}

function lint {
    local full_file=$1
    # extract first directory out of path
    local file=`echo ${full_file} | sed 's,^[^/]*/,,'`
    local extension=`echo ${file} | awk -F"." '{print $NF}'`
    local pass=true
    echo "File to lint ${full_file} of extension ${extension}"

    # invoke corresponding linter
    case "${extension}" in
      sh) echo "Linting: Shell Script"
        shellcheck ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      js) echo "Linting: JavaScript file"
        eslint ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      go) echo "Linting: GO file"
        golint ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      py) echo "Linting: Python file"
        pylint ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      md) echo "Linting: Markdown file"
        mdl ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      json) echo "Linting: JSON file"
        jsonlint ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      yaml) echo "Linting: YAML file"
        yamllint ${file}
        if [ $? -ne 0 ]; then
          pass=false
        fi
        ;;
      *) echoerr "Invalid file extension ${extension}"
        exit 5
    esac

    if [ ${pass} ]; then
      echo 0
    else
      echo 666
    fi
}

# ###########################################################
# M A I N   L O G I C
# ###########################################################

if [ $(id -u) = 0 ]; then
   echo "Do not run as root!!!!"
   exit 2
fi

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E ".sh|.py|.js|.yaml|.json|.go|.md$")

if [[ "$STAGED_FILES" = "" ]]; then
  echo "No files staged for commit"
  exit 0
fi

IS_MAC=false
IS_LINUX=false

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  IS_LINUX=true
elif [[ "$OSTYPE" == "darwin"* ]]; then
  IS_MAC=true
else
  echoerr "Unsupported operating system"
  exit 1
fi

# Check Linters installed
for i in "${TOOLS_TO_INSTALL[@]}"
do
  rc=$(cmd_exists $i)
  if [ "$rc" -ne "0" ]; then
    echoerr "Missing linter - please install ${i}"
    exit 3
  fi
done

# Invoke linter, error msg, and exit when/where applicable
fail=false
for FILE in $STAGED_FILES
do
  rc=$(lint ${FILE})
  if [ "$rc" -ne "0" ]; then
    fail=true
  fi
done

if [ ${fail} ]; then
  exit 4
else
  exit 0
fi
