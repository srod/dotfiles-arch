#!/bin/bash

# System
print_in_blue "\n   Packages - System\n\n"
package_install "Bat" "bat"
package_install "Ncdu" "ncdu"
package_install "Ngrep" "ngrep"
package_install "Nmap" "nmap"
package_install "Prettyping" "prettyping"
package_install "Tcpdump" "tcpdump"
package_install "Vim" "vim"
execute \
    "sudo systemctl enable systemd-resolved" \
    "Enable systemd-resolved"
package_install "Java" "jre-openjdk-headless"
package_install "Diff so Fancy" "diff-so-fancy"
yay_install "Extfat" "sdfat-dkms"
yay_install "Exfat utils" "exfat-utils-nofuse"
package_install "Xclip" "xclip"
package_install "Neofetch" "neofetch"
package_install "Htop" "htop"
yay_install "Gotop" "gotop-bin"
package_install "Ntfs-3g" "ntfs-3g"
package_install "android-udev" "android-udev"

# Thunderbolt
package_install "Bolt" "bolt"
execute \
    "sudo systemctl start bolt.service" \
    "Enable bolt service"

# Network
print_in_blue "\n   Packages - Network\n\n"
package_install "OpenSSH" "openssh"
package_install "Bind Tools" "bind-tools"
package_install "cifs-utils" "cifs-utils"
execute \
    "sudo rm /etc/krb5.conf" \
    "Optimize samba"
package_install "Google Drive" "kio-gdrive"

# Security
package_install "Clamav" "clamav"
execute \
    "sed -i '/Example/d' /etc/clamav/freshclam.conf && sed -i '/Example/d' /etc/clamav/clamd.conf" \
    "Set up Clamav config files"
execute \
    "sudo systemctl enable clamav-daemon.service" \
    "Enable Clamav"
execute \
    "sudo systemctl enable clamav-freshclam.service" \
    "Enable Freshclam"
package_install "UFW" "ufw gufw"
execute \
    "sudo systemctl enable ufw.service" \
    "Enable UFW"

# Browsers
print_in_blue "\n   Packages - Browsers\n\n"
yay_install "Brave" "brave-bin"
package_install "Chromium" "chromium"
package_install "Firefox" "firefox"

# Set Brave as default browser
#execute \
#    "xdg-settings set default-web-browser brave-bin.desktop" \
#    "Set Brave as default browser"

# Mail
print_in_blue "\n   Packages - Mail\n\n"
package_install "Thunderbird" "thunderbird"
package_install "Mailspring" "mailspring gnome-keyring"

# GPG
print_in_blue "\n   Packages - GPG\n"
yay_install "Keybase" "keybase-bin"

# IDE
print_in_blue "\n   Packages - IDE\n\n"
yay_install "Sublime Text" "sublime-text-dev"
yay_install "Visual Studio Code" "visual-studio-code-bin"

# Terminal
print_in_blue "\n   Packages - Terminal\n\n"
package_install "ZSH Completions" "zsh-completions"

# Utilities
yay_install "Dropbox" "dropbox"
yay_install "Pamac" "pamac-aur"
yay_install "Razer" "python-notify2 polychromatic"
execute \
    "sudo systemctl enable vmware-networks.service" \
    "Add VMware Network"
execute \
    "sudo systemctl enable vmware-usbarbitrator.service" \
    "Add VMware USB"
execute \
    "sudo systemctl enable vmware-hostd.service" \
    "Add VMware Hostd"
yay_install "Simple Note" "simplenote-electron-bin"
package_install "libnotify" "libnotify"
yay_install "Insync" "insync"
yay_install "vmware-workstation"
execute \
    "sudo gpasswd -a rodolphe vboxusers" \
    "Add rodolphe to vboxusers"
package_install "VMware Tools" "open-vm-tools"
package_install "Virtualbox" "virtualbox"
package_install "Virtualbox Guest ISO" "virtualbox-guest-iso"
yay_install "Virtualbox Extensions" "virtualbox-ext-oracle"
execute \
    "sudo gpasswd -a rodolphe vboxusers" \
    "Add rodolphe to vboxusers"
package_install "Meld" "meld"
package_install "Kdiff3" "kdiff3"
package_install "Unrar" "unrar"
package_install "PDF Arranger" "pdfarranger"
yay_install "Moneydance" "moneydance"
package_install "Youtube dl" "youtube-dl"
yay_install "BalenaEtcher" "etcher-bin"

# Videos
print_in_blue "\n   Packages - Videos\n\n"
package_install "VLC" "vlc"
package_install "Shotcut" "shotcut"
package_install "Kdenlive" "kdenlive"

# Fonts
print_in_blue "\n   Packages - Fonts\n\n"
yay_install "Hack Nerd" "nerd-fonts-hack"
yay_install "TTF ms fonts" "ttf-ms-fonts"
yay_install "TTF Monaco" "ttf-monaco"
yay_install "TTF Vista Fonts" "ttf-vista-fonts"
yay_install "TTF Google Fonts" "ttf-google-fonts-git"
package_install "TTF Dejavu" "ttf-dejavu"
yay_install "TTF Fira Code" "ttf-fira-code"
package_install "TTF Liberation" "ttf-liberation"
package_install "Noto Fonts" "noto-fonts"
package_install "Emoji" "noto-fonts-emoji"
package_install "TTF Inconsolata" "ttf-inconsolata"
package_install "Terminus Font" "terminus-font"
package_install "Cantarell Fonts" "cantarell-fonts"
package_install "TTF Bitstream Vera" "ttf-bitstream-vera"
package_install "TTF Hack" "ttf-hack"
yay_install "TTF Mac Fonts" "ttf-mac-fonts"

# Office
package_install "Libre Office" "libreoffice-fresh libreoffice-fresh-fr"
yay_install "Microsoft Office Online" "ms-office-online"

# Printers
package_install "Printers" "cups cups-pdf ghostscript gsfonts libcups system-config-printer simple-scan --noconfirm --needed"
execute \
    "sudo gpasswd -a rodolphe lp" \
    "Add rodolphe to lp group"

# Drivers Epson XP-700
yay_install "Drivers Epson XP-700" "epson-inkjet-printer-201208w"

execute \
    "sudo systemctl enable org.cups.cupsd --now" \
    "Enable printer service"

# Themes
echo "Install Theme ? (Y/n)"

read case;
case $case in

Y)

yay_install "Themes" "numix-gtk-theme numix-frost-themes numix-circle-icon-theme-git arc-gtk-theme materia-gtk-theme paper-icon-theme papirus-icon-theme"
yay_install "Themes" "equilux-theme faba-icon-theme-git flat-remix-git"

execute \
    "git clone https://github.com/vinceliuice/Mojave-gtk-theme.git && cd Mojave-gtk-theme && ./install.sh && cd .. && rm -rf Mojave-gtk-theme" \
    "Install Mojave Theme"

;;
esac

# OS Prober
package_install "OS Prober" "os-prober"
execute \
    "sudo os-prober && sudo grub-mkconfig -o /boot/grub/grub.cfg" \
    "Enable windows partition to grub"

# YARN
if [ -d "$HOME/.nvm" ]; then
    print_in_blue "\n   Packages - Node\n\n"
    package_install "Yarn" "yarn"
fi
