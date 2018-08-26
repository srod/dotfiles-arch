#!/bin/bash

###############################################################################

### Installing Arch Linux By: ###

### Erik Sundquist ###

###############################################################################

### Review and edit before using ###

###############################################################################



set -e

clear



echo "################################################################################"

echo "### Activate connection ###"

echo "################################################################################"



nmtui



clear



echo "################################################################################"

echo "### Installing YAY ###"

echo "################################################################################"



sleep 2



git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si --noconfirm --needed --asdeps

cd ..

rm yay -R -f



clear



echo "################################################################################"

echo "### Install and setup display manager and desktop ###"

echo "################################################################################"



sleep 2



sudo pacman -S --noconfirm --needed --asdeps xf86-video-intel mesa xorg-server bumblebee bbswitch-dkms nvidia nvidia-settings primus

sudo gpasswd -a rodolphe bumblebee
sudo gpasswd -a rodolphe video

sudo systemctl enable bumblebeed.service



echo "################################################################################"

echo "What is your preferred desktop environment"

echo "1) KDE Plasma"

echo "2) XFCE4"

echo "################################################################################"


read case;

case $case in

1)


echo "You selected KDE Plasma"

sudo pacman -S --noconfirm --needed --asdeps plasma-meta kde-applications-meta sddm

sudo systemctl enable sddm

sudo pacman -S --noconfirm --needed --asdeps packagekit-qt5 kdenetwork-filesharing kdeconnect

yay -S --noconfirm --needed --asdeps plasma-thunderbolt-git

yay -S --noconfirm --needed --asdeps samba-mounter-git


;;

2)


echo "You selected XFCE4"

sudo pacman -S --noconfirm --needed --asdeps xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

sudo systemctl enable lightdm

sudo pacman -S --noconfirm --needed --asdeps xarchiver network-manager-applet file-roller galculator

yay -S --noconfirm --needed --asdeps mugshot xfdashboard


;;

esac


clear



echo "################################################################################"

echo "### Set locale X11 ###"

echo "################################################################################"



sudo localectl set-keymap fr
sudo localectl set-x11-keymap fr



clear



echo "################################################################################"

echo "### Installing needed ###"

echo "################################################################################"



sudo pacman -S --noconfirm --needed --asdeps gvfs-afc gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb



clear



echo "################################################################################"

echo "### Setup user dirs ###"

echo "################################################################################"



sudo pacman -S --noconfirm --needed --asdeps xdg-user-dirs xdg-user-dirs-gtk

xdg-user-dirs-update

xdg-user-dirs-gtk-update



clear



echo "################################################################################"

echo "### Installation completed, please reboot when ready ###"

echo "################################################################################"



sleep 2
