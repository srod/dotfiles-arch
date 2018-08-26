#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

print_in_blue "\n • Installs\n\n"

sh ./src/xcode.sh
#sh ./src/homebrew.sh
#sh ./src/zsh.sh
#sh ./src/nvm.sh
#sh ./src/brew.sh
#sh ./src/npm.sh
#sh ./src/mas.sh
#sh ./src/ruby.sh
#sh ./src/gem.sh
#sh ./src/opam.sh
#sh ./src/cleanup.sh
