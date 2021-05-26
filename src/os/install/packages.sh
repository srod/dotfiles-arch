#!/bin/bash

# System
print_in_blue "\n   Packages - System\n\n"
package_install "base-devel" "base-devel"
package_install "binutils" "binutils"
package_install "YAY" "yay"
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
package_install "Xclip" "xclip"
package_install "Neofetch" "neofetch"
package_install "Htop" "htop"

# Network
print_in_blue "\n   Packages - Network\n\n"
package_install "Bind Tools" "bind-tools"

# Browsers
print_in_blue "\n   Packages - Browsers\n\n"
package_install "Chromium" "chromium"
package_install "Firefox" "firefox"

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
yay_install "Insync" "insync"
package_install "VMware Tools" "open-vm-tools"
package_install "Meld" "meld"
package_install "Kdiff3" "kdiff3"
package_install "Unrar" "unrar"

# Fonts
print_in_blue "\n   Packages - Fonts\n\n"
yay_install "Hack Nerd" "nerd-fonts-hack"
yay_install "TTF ms fonts" "ttf-ms-fonts"
yay_install "TTF Fira Code" "ttf-fira-code"

# Office
package_install "Libre Office" "libreoffice-fresh libreoffice-fresh-fr"
yay_install "Libre Office French Dictionary" "libreoffice-extension-grammalecte-fr"

# YARN
if [ -d "$HOME/.nvm" ]; then
    print_in_blue "\n   Packages - Node\n\n"
    package_install "Yarn" "yarn"
fi
