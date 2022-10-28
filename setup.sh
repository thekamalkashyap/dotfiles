#!/bin/bash

clear

# upgrade
sudo dnf upgrade

# enabling rpm fusion repo
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# flathub repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# config dnf for faster download
echo '
# config dnf for faster download
fastestmirror=true
deltarpm=true
max_parallel_downloads=10' | tee -a /etc/dnf/dnf.conf

# install gnome tweaks, extensions app and fedy
sudo dnf install gnome-tweaks gnome-extensions-app

# setup tlp
sudo dnf remove power-profiles-daemon
sudo dnf install tlp tlp-rdw && systemctl enable tlp.service && systemctl mask systemd-rfkill.service systemd-rfkill.socket

# installing rust 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# installing  packages i need
sudo dnf install nodejs python fzf dwm sxiv xclip lynx pass trash-cli tldr blender git
sudo npm i -g n

# copying .aliases to home
sudo cp ./.aliases $HOME/

# updating .bashrc
echo '
export GOPATH=$HOME/kamal/go
export PATH="$PATH:$HOME/go/bin"

# fzf config
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%" 

# my aliases 
if [ -f $HOME/.aliases ]; then
        . $HOME/.aliases
fi

PS1="\W@$(whoami) >" ' | tee -a $HOME/.bashrc
