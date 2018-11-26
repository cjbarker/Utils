#!/bin/sh

# update repos
add-apt-repository ppa:masterminds/glide
add-apt-repository ppa:gophers/archive

apt update
apt -y upgrade
apt dist-upgrade

apt install -y linux-headers-$(uname -r)
apt install -y mono-complete
apt install -y vim
apt install -y glances
apt install -y jq
apt install -y whois
apt install -y make
apt install -y build-essential
apt install -y pip python-pip python3-pip python-dev python3-dev python-setuptools
apt install -y python3-opencv
apt install -y curl wget
apt install -y git
apt install -y git-flow
apt install -y golang-1.10-go
apt install -y glide
apt install -y tree
apt install -y bash-completion
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
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install oracle-java8-installer

# NodeJS
apt install -y python-software-properties
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
apt install -y nodejs nodejs-legacy npm

# NTP
apt install -y ntpdate
ntpdate -s time.nist.gov

# Google Drive
add-apt-repository ppa:alessandro-strada/ppa
apt update
apt install -y google-drive-ocamlfuse
google-drive-ocamlfuse
mkdir -p ~/google-drive
google-drive-ocamlfuse ~/google-drive

# skype
dpkg --add-architecture i386
apt-get update
wget -O skype-install.deb http://www.skype.com/go/getskype-linux-deb
dpkg -i skype-install.deb
apt-get -f -y install
rm -rf skype-install.deb

apt autoremove -y
