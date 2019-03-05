# ############################################
#!/bin/bash
#
# Mac OSX dotFile for setting up environment
# ############################################

declare -a BREW_CLI
declare -a BREW_GUI

BREW_CLI=(bash pkg-config libtool openssl git go python python3 node ruby hugo protobuf mono sqlite kubectl wget fzf htop tree nmap bash-completion dos2unix geoip git-flow unrar tmux ack ffmpeg imagemagick watch speedtest_cli ansiweather clang cmake bazel maven ant gradle ttygif bro tldr thefuck httpstat terraform rsync opencv tidy-html5 p7zip youtube-dl coreutils awscli pidof autojump cloc pstree automake autoconf chromedriver mitmproxy lzip sslmate cppcheck tflint pandoc prettier jsonlint alexjs checkstyle pmd google-java-format)

BREW_GUI=(java java8 vivaldi spectacle wireshark virtualbox zoomus skype android-studio eclipse-java slack visual-studio-code dash gimp flux spectacle android-sdk handbrake easyfind keybase google-backup-and-sync)

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
# Install non-brew various tools (PRE-BREW Installs)
# ###########################################################
# invoke xcode install from app store
xcode-select --install
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept

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
brew cleanup
brew doctor

# pull tap libs
brew tap homebrew/cask
brew tap caskroom/versions
brew tap wata727/tflint
brew tap miktex/miktex

# Ruby Gems
sudo gem install cocoapods
sudo gem install fastlane
sudo gem install jazzy

# python
#brew install pyenv
#export PYTHON_CONFIGURE_OPTS="--enable-framework"
#pyenv install 2.7.14
#pyenv install 3.6.3
#pyenv local 2.7.14

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

# Special flags for brew
brew install macvim --with-override-system-vi
ln -s /usr/local/bin/mvim /usr/local/bin/vim

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
# Install non-brew various tools (POST-BREW Installs)
# ###########################################################
# VIM Vuncle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Python3 Jupyter Notebook
python3 -m pip install --upgrade pip
python3 -m pip install jupyter

# Python2 Updates
pip install --upgrade pip setuptools

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

# ###########################################################
# SETUP DEFAULTS
# ###########################################################
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"
defaults write com.apple.finder AppleShowAllFiles -bool YES
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g QLPanelAnimationDuration -float 0
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.Dock autohide-delay -float 0
defaults write com.apple.Safari WebKitInitialTimedLayoutDelay 0.25
defaults write com.google.Chrome AppleLanguages '(en-US)'
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Keystone.Agent checkInterval 172800
defaults write com.apple.dashboard devmode YES
# disable reopen windows in logging back in
defaults write com.apple.loginwindow TALLogoutSavesState -bool false
defaults write com.apple.loginwindow LoginwindowLaunchesRelaunchApps -bool false
defaults write com.apple.dock expose-animation-duration -float 0.12
defaults write com.apple.Dock showhidden -bool YES
defaults write com.apple.finder CreateDesktop -bool false
defaults write com.apple.screencapture location ~/Downloads/screenshots

killall Finder
killall Dock
