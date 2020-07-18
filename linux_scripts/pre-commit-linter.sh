#!/bin/sh

# #####################################################
# Applies Git pre-commit hook to link appropriate file
# when applicable: Markdown, JavaScript, Go, Python,
# TypeScript.
#
#
#
# #####################################################

# Logic/Flow
# Check file extension: .md (markdown)
# Check if given linter command exist: mdl
# Run linter
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

# ###########################################################
# M A I N   L O G I C
# ###########################################################

if [ $(id -u) = 0 ]; then
   echo "Do not run as root!!!!"
   exit 2
fi

STAGED_FILES=$(git diff --cached --name-only --diff-filter=ACM | grep -E ".sh|.py\{0,1\}$")

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

# Prereq installation for Mac
if [[ "${IS_MAC}" == true ]]; then
  rc=$(cmd_exists brew)
  if [ "$rc" -ne "0" ]; then
      echo -e 'Installing Brew'
      bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
      brew update
      brew upgrade
  fi
fi
# TODO prereq linux install

# TODO loop through tools and install as necessary
for i in "${TOOLS_TO_INSTALL[@]}"
do
  #echo $i
  rc=$(cmd_exists $i)
  if [ "$rc" -ne "0" ]; then
    echoerr "Missing linter - please install ${i}"
    exit 2
  fi
done

PASS=true

echo "\nValidating Javascript:\n"

# Check for eslint
which eslint &> /dev/null
if [[ "$?" == 1 ]]; then
  echo "\t\033[41mPlease install ESlint\033[0m"
  exit 1
fi

for FILE in $STAGED_FILES
do
  eslint "$FILE"

  if [[ "$?" == 0 ]]; then
    echo "\t\033[32mESLint Passed: $FILE\033[0m"
  else
    echo "\t\033[41mESLint Failed: $FILE\033[0m"
    PASS=false
  fi
done

echo "\nJavascript validation completed!\n"

if ! $PASS; then
  echo "\033[41mCOMMIT FAILED:\033[0m Your commit contains files that should pass ESLint but do not. Please fix the ESLint errors and try again.\n"
  exit 1
else
  echo "\033[42mCOMMIT SUCCEEDED\033[0m\n"
fi

exit $?
