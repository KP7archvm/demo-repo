#!/bin/bash

ver="1.0"
pacconf=/etc/pacman.conf

echo "Setting up pacman keys for Chaotic AUR"
sudo pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com
sudo pacman-key --lsign-key FBA220DFC880C036
sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
echo "Setting pacman keys done"

echo "Now appending chaotic-aur lines to pacman configuration file"
sudo echo "[chaotic-aur]" >> $pacconf
sudo echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> $pacconf

if grep "chaotic-aur" $pacconf
then
echo " Chaotic AUR has been succesfully installed."
echo "Now lets update the system"
sudo pacman -Syu
fi

echo "Installing the specified packages"
sudo pacman -Syu htop vivaldi-snapshot octopi kate gimp onlyoffice-bin fish neofetch brave-nightly-bin

echo "Changing the login shell to the fish shell"
sudo chsh -s /bin/fish

echo "Setup completed. Enjoy."
