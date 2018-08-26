#!/bin/bash

declare -r RUBY_VERSION="2.5.5"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_ruby() {

    yay_install "Rbenv" "rbenv"
    yay_install "Ruby-build" "ruby-build"
    execute "rbenv install '$RUBY_VERSION'" "Install"
    execute "rbenv global '$RUBY_VERSION'" "Set global '$RUBY_VERSION'"
    execute ". $LOCAL_SHELL_CONFIG_FILE" "Load env"
    execute "gem update --system" "Update system"
    execute "gem update" "Update"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   Ruby\n\n"

    install_ruby

}

main
