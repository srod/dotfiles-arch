#!/bin/bash

###############################################################################

### Installing Arch Linux By: ###

### Erik Sundquist ###

###############################################################################

### Review and edit before using ###

###############################################################################



set -e

clear



#echo "################################################################################"

#echo "### Activate connection ###"

#echo "################################################################################"



#nmtui



#clear



echo "################################################################################"

echo "### Installing YAY ###"

echo "################################################################################"



sleep 2



git clone https://aur.archlinux.org/yay.git

cd yay

makepkg -si --noconfirm --needed --asdeps

cd ..

rm yay -R -f

sleep 2

clear



echo "################################################################################"

echo "### Install and setup display manager and desktop ###"

echo "################################################################################"



sleep 2



sudo pacman -S --noconfirm --needed --asdeps xf86-video-intel mesa xorg-server bumblebee bbswitch-dkms nvidia nvidia-settings primus

sudo gpasswd -a rodolphe bumblebee
sudo gpasswd -a rodolphe video

sudo systemctl enable bumblebeed.service

sleep 2

clear



echo "################################################################################"

echo "What is your preferred desktop environment"

echo "1) KDE Plasma"

echo "2) KDE Plasma Minimal"

echo "3) XFCE4"

echo "4) Gnome"

echo "################################################################################"


read case;

case $case in

1)


echo "You selected KDE Plasma"

sudo pacman -S --noconfirm --needed --asdeps plasma-meta sddm

sudo systemctl enable sddm

sudo pacman -S --noconfirm --needed --asdeps packagekit-qt5 kdenetwork-filesharing

#yay -S --noconfirm --needed --asdeps plasma-thunderbolt-git

yay -S --noconfirm --needed --asdeps samba-mounter-git


;;

2)


echo "You selected KDE Plasma Minimal"

sudo pacman -S --noconfirm --needed --asdeps plasma-desktop sddm

sudo systemctl enable sddm

sudo pacman -S --noconfirm --needed --asdeps kwallet-pam xf86-input-libinput xf86-input-synaptics bluedevil kscreen plasma-browser-integration plasma-nm plasma-pa plasma-thunderbolt

sudo pacman -S --noconfirm --needed --asdeps powerdevil sddm-kcm breeze-grub dolphin kwrite kfind gwenview okular spectacle svgpart

sudo pacman -S --noconfirm --needed --asdeps audiocd-kio dragon kmix akonadi-calendar-tools ark kcalc kgpg print-manager sweeper ksshaskpass



;;

3)


echo "You selected XFCE4"

sudo pacman -S --noconfirm --needed --asdeps xfce4 xfce4-goodies lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings

sudo systemctl enable lightdm

sudo pacman -S --noconfirm --needed --asdeps xarchiver network-manager-applet file-roller galculator gnome-keyring

yay -S --noconfirm --needed --asdeps mugshot xfdashboard


;;

4)


echo "You selected Gnome"

sudo pacman -S --noconfirm --needed --asdeps gdm gnome-control-center gnome-terminal gnome-keyring gnome-tweak-tool

sudo pacman -S --noconfirm --needed --asdeps gedit eog nautilus gnome-photos gnome-contacts evince gnome-calculator gnome-power-manager

sudo pacman -S --noconfirm --needed --asdeps gnome-screenshot gnome-search-tool gnome-bluetooth gnome-menus

sudo pacman -S --noconfirm --needed --asdeps nvidia

sudo systemctl enable gdm.service


;;

esac


sleep 2

clear



echo "################################################################################"

echo "### Set locale X11 ###"

echo "################################################################################"



sleep 2



sudo localectl set-keymap fr
sudo localectl set-x11-keymap fr

sleep 2

clear



echo "################################################################################"

echo "### Installing needed ###"

echo "################################################################################"



sleep 2



sudo pacman -S --noconfirm --needed --asdeps gvfs-afc gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb

sleep 2

clear



echo "################################################################################"

echo "### Setup user dirs ###"

echo "################################################################################"



sleep 2



sudo pacman -S --noconfirm --needed --asdeps xdg-user-dirs xdg-user-dirs-gtk

xdg-user-dirs-update

xdg-user-dirs-gtk-update

sleep 2

clear



echo "################################################################################"

echo "### Power Management ###"

echo "################################################################################"



sleep 2



sudo pacman -S --noconfirm --needed --asdeps tlp
sudo pacman -S --noconfirm --needed --asdeps tlp-rdw

#sudo echo 'RUNTIME_PM_BLACKLIST="08:00.0 08:00.1"' >> /etc/default/tlp

sudo systemctl enable tlp
sudo systemctl enable tlp-sleep

sleep 2

clear



echo "################################################################################"

echo "### Installation completed, please reboot when ready ###"

echo "################################################################################"



sleep 2
