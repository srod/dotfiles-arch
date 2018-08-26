#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

declare -r RUBY_VERSION="2.5.1"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_ruby() {

    brew_install "Brew rbenv" "rbenv"
    execute "rbenv install '$RUBY_VERSION'" "Install"
    execute "rbenv global '$RUBY_VERSION'" "Set global '$RUBY_VERSION'"
    execute "gem update --system" "Update system"
    execute "gem update" "Update"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   Ruby\n\n"

    install_ruby

}

main