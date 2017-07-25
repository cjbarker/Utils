# ############################################
#!/bin/bash
#
# Mac OSX dotFile for setting up environment
# ############################################

declare -a BREW_CLI
declare -a BREW_GUI

BREW_CLI=(go python mono wget htop tree nmap bash-completion dos2unix geoip git-flow unrar tmux ack ffmpeg imagemagick watch speedtest_cli ansiweather cmake maven ant gradle ttygif bro tldr thefuck httpstat terraform macvim rsync opencv tidy-html5) 

BREW_GUI=(google-chrome java vlc iterm2 macvim virtualbox spotify skype android-studio eclipse-java slack visual-studio-code dash gimp brave flux spectacle github-desktop google-earth-pro android-sdk lastpass handbrake easyfind keybase)

function echoerr {
    echo "$@" 1>&2
}

function cmd_exists
{
    local cmd=$1
    local result=`which $cmd`

    if [ -n "$result" ]; then
        echo 0
    else 
        #echoerr "Command ${1} does not exist. Unable to execute script."
        echo 1
    fi 
}

# Install non-brew various tools 
xcode-select --install
pip2 install --upgrade pip setuptools
pip install virtualenv

rc=`cmd_exists brew`
if [ "$rc" -ne "0" ]; then
    echo -e 'Installing Brew'
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi 

# Update Brew
brew update
brew upgrade
brew prune
brew cleanup
brew doctor

# pull tap libs
brew tap homebrew/science

# Install Brew CLI apps
for cmd in "${BREW_CLI[@]}"
do
    #echo ${cmd}
    brew install ${cmd}
    if [ "$?" -ne "0" ]; then
        echoerr "Failed to install ${cmd}"
        exit $rc 
    fi 
done

# Install Cask GUI Apps
for app in "${BREW_GUI[@]}"
do
    #echo ${app}
    brew cask info "${app}" | grep --quiet 'Not installed' && brew cask install "${app}"
    brew cask install --appdir="/Applications" ${app}
    if [ "$?" -ne "0" ]; then
        echoerr "Failed to install ${app}"
        exit $rc 
    fi 
done

# cleanup
brew cleanup --force
rm -f -r /Library/Caches/Homebrew/*

# Install dotFile configurations


