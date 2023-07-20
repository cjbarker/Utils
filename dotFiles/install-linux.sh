#!/bin/sh

# update repos
apt update
apt -y upgrade
apt dist-upgrade

apt install -y linux-headers-$(uname -r)
apt install -y mono-complete
apt install -y vim
apt install -y glances
apt install -y xclip
apt install -y jq
apt install -y whois
apt install -y make
apt install -y build-essential
apt install -y pip python-pip python3-pip python-dev python3-dev python-setuptools
apt install -y python3-opencv
apt install -y curl wget
apt install -y git
apt install -y git-flow
apt install -y golang-go
apt install -y tree
apt install -y bash-completion
apt install -y tidy
apt install -y htop
apt install -y httpstat
apt install -y nmap
apt install -y dos2unix
apt install -y tmux
apt install -y unrar
apt install -y ack-grep
apt install -y ffmpeg
apt install -y imagemagick
apt install -y ansiweather
apt install -y cmake
apt install -y maven
apt install -y ant
apt install -y gradle
apt install -y bro
apt install -y thefuck
apt install -y p7zip
apt install -y youtube-dl
apt install -y coreutils
apt install -y awscli
apt install -y autojump
apt install -y cloc
apt install -y pstree
apt install -y automake
apt install -y autoconf
apt install -y mitmproxy
apt install -y gimp
apt install -y virtualbox
apt install -y i3
apt install -y conky
apt install -y gnome-control-center
apt install -y gnome-online-accounts
apt install -y xfonts-terminus
apt install -y default-jre
apt install -y default-jdk
apt install -y texlive-full
apt install -y texmaker
apt install -y libssl-dev
apt-get update
apt-get install oracle-java8-installer

# Exa
apt install -y libgit2-24 libgit2-dev cmake
# install rust
curl https://sh.rustup.rs -sSf | sh
# install exa
wget -c https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip
unzip exa-linux-*.zip
mv exa-linux-x86_64 /usr/local/bin/exa
rm -rf exa-linux-*.zip

# NodeJS
apt install -y python-software-properties
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
apt install -y nodejs npm

# NPM Packages
npm install -g typescript
npm install -g react
npm install -g react-native
npm install -g react-native-cli
npm install -g aws-sdk
npm install -g jshint

# Diff-so-fancy
wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy -O /usr/local/bin/.
chmod 755 /usr/local/bin/diff-so-fancy

# NTP
apt install -y ntpdate
ntpdate -s time.nist.gov

# skype
dpkg --add-architecture i386
apt-get update
wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
dpkg -i skype-install.deb
apt-get -f -y install
rm -rf skype-install.deb

apt autoremove -y

# ssh key setup
if [ -d ~/.ssh ]; then
    chmod 700 ~/.ssh
    chmod 644 ~/.ssh/authorized_keys
    chmod 644 ~/.ssh/known_hosts
    chmod 644 ~/.ssh/config
    chmod 600 ~/.ssh/*_rsa
    chmod 644 ~/.ssh/*.pub
    chown -R ${USER} ~/.ssh/

    ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

    # import certs
    eval "$(ssh-agent -s)"
    ssh-add -K ~/.ssh/*_rsa
fi

