#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#print_in_blue "\n   Brews\n"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

#printf "\n"

# System
print_in_blue "\n   Brews - System\n\n"
brew_install "Coreutils" "coreutils"
brew_install "Findutils" "findutils"
brew_install "Wget" "wget --with-iri"
brew_install "Grep" "grep --with-default-names"
brew_install "Curl" "curl --with-nghttp2"
brew_install "Git" "git"
brew_install "Vim" "vim --with-override-system-vi"
brew_install "Mac App Store" "mas"
brew_install "Neofetch" "neofetch"
brew_install "Python 2" "python@2"
brew_install "Python 3" "python@3"
brew_install "GPG" "gpg"

# Browsers
print_in_blue "\n   Brews - Browsers\n\n"
brew_install "Chrome" "google-chrome" "caskroom/cask" "cask"
brew_install "Firefox" "firefox" "caskroom/cask" "cask"
brew_install "Brave" "brave" "caskroom/cask" "cask"

# Cleaners
print_in_blue "\n   Brews - Cleaners\n\n"
brew_install "Onyx" "onyx" "caskroom/cask" "cask"
brew_install "Malwarebytes" "malwarebytes" "caskroom/cask" "cask"

# File Comparison
print_in_blue "\n   Brews - File Comparison\n\n"
brew_install "Kaleidoscope" "kaleidoscope" "caskroom/cask" "cask"

# GPG
print_in_blue "\n   Brews - GPG\n"
brew_install "Keybase" "keybase" "caskroom/cask" "cask"

# IDE
print_in_blue "\n   Brews - IDE\n\n"
brew_install "Visual Studio Code" "visual-studio-code" "caskroom/cask" "cask"
brew_install "Sublime Text" "sublime-text" "caskroom/cask" "cask"
brew_install "Webstorm" "webstorm" "caskroom/cask" "cask"

# Instagram
print_in_blue "\n   Brews - Instagram\n\n"
brew_install "Flume" "flume" "caskroom/cask" "cask"

# Java
print_in_blue "\n   Brews - Java\n\n"
brew_install "Java" "java" "caskroom/cask" "cask"

# Password Manager
print_in_blue "\n   Brews - Password Manager\n\n"
brew_install "1password" "1password" "caskroom/cask" "cask"

# Security
print_in_blue "\n   Brews - Security\n\n"
brew_install "Authy" "authy" "caskroom/cask" "cask"
brew_install "Micro Snitch" "micro-snitch" "caskroom/cask" "cask"
brew_install "Oversight" "oversight" "caskroom/cask" "cask"
brew_install "GPG Suite" "gpg-suite" "caskroom/cask" "cask"
brew_install "Avast Security" "avast-security" "caskroom/cask" "cask"

# Subtitles
print_in_blue "\n   Brews - Subtitles\n\n"
brew_install "SubsMarine" "subsmarine" "caskroom/cask" "cask"

# Terminal
print_in_blue "\n   Brews - Terminal\n\n"
brew_install "iTerm2" "iterm2" "caskroom/cask" "cask"
brew_install "Hyper" "hyper" "caskroom/cask" "cask"

# Unarchivers
print_in_blue "\n   Brews - Unarchivers\n\n"
brew_install "The Unarchiver" "the-unarchiver" "caskroom/cask" "cask"

# Usenet
print_in_blue "\n   Brews - Usenet\n\n"
brew_install "Panic Unison" "panic-unison" "caskroom/cask" "cask"

# Utilities
print_in_blue "\n   Brews - Utilities\n\n"
brew_install "Keeping you awake" "keepingyouawake" "caskroom/cask" "cask"
brew_install "Istat Menus" "istat-menus" "caskroom/cask" "cask"
brew_install "Dropbox" "dropbox" "caskroom/cask" "cask"

# Videos
print_in_blue "\n   Brews - Videos\n\n"
brew_install "VLC" "vlc" "caskroom/cask" "cask"

# VPN
print_in_blue "\n   Brews - VPN\n\n"
brew_install "Tunnelblick" "tunnelblick" "caskroom/cask" "cask"

# Windows Manager
print_in_blue "\n   Brews - Windows Manager\n\n"
brew_install "Slate" "slate" "caskroom/cask" "cask"
#brew_install "Cinch" "cinch" "caskroom/cask" "cask"

# Development
print_in_blue "\n   Brews - Development\n\n"
brew_install "Postman" "postman" "caskroom/cask" "cask"

# Capture
#print_in_blue "\n   Brews - Capture\n\n"
#brew_install "Licecap" "licecap" "caskroom/cask" "cask"

# Monitor
print_in_blue "\n   Brews - Monitor\n\n"
brew_install "Stay" "stay" "caskroom/cask" "cask"
#brew_install "SwitchResX" "SwitchResX" "caskroom/cask" "cask"

# Optimisations
print_in_blue "\n   Brews - Optimisations\n\n"
brew_install "ImageOptim" "imageoptim" "caskroom/cask" "cask"

if [ -d "$HOME/.nvm" ]; then
    brew_install "Yarn" "yarn" "" "" "--without-node"
fi