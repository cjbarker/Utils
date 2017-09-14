# ############################################
#!/bin/bash
#
# Mac OSX dotFile for setting up environment
# ############################################

declare -a BREW_CLI
declare -a BREW_GUI

BREW_CLI=(go python jython python3 mono wget htop tree nmap bash-completion dos2unix geoip git-flow unrar tmux ack ffmpeg imagemagick watch speedtest_cli ansiweather cmake maven ant gradle ttygif bro tldr thefuck httpstat terraform macvim rsync opencv tidy-html5 p7zip youtube-dl coreutils awscli pidof autojump cloc pstree automake autoconf chromedriver mitmproxy) 

BREW_GUI=(wireshark google-chrome java vlc iterm2 macvim virtualbox spotify skype android-studio eclipse-java slack visual-studio-code dash gimp brave flux spectacle github-desktop google-earth-pro android-sdk lastpass handbrake easyfind keybase balsamiq-mockups owasp-zap)

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

# ###########################################################
# Install non-brew various tools 
# ###########################################################
xcode-select --install
pip2 install --upgrade pip setuptools
pip install virtualenv
pip install python-owasp-zap-v2.4 --user

# Python Scapy
curl -L https://github.com/dugsong/libdnet/archive/libdnet-1.12.zip -o libdnet-1.12.zip
unzip libdnet-1.12.zip
cd libdnet-libdnet-1.12
./configure
make
sudo make install
cd python
python setup.py install --user
pip install pypcap --user
pip install scapy --user
pip install pyx==0.12.1 -I --no-cache --user
sudo pip install user pycrypto
pip install ecdsa  --user

# ###########################################################
# BREW INSTALLS
# ###########################################################
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


# ###########################################################
# Install dotFile configurations
# ###########################################################
if [ -f .bashrc ]; then
    cp .bashrc ~/.
fi

if [ -f .profile ]; then
    cp .profile ~/.
fi

if [ -f .gitconfig ]; then
    cp .gitconfig ~/.
fi

if [ -f .gitignore ]; then
    cp .gitignore ~/.
fi

source ~/.profile

