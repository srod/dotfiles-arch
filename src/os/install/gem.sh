#!/bin/bash

install_gems() {

    execute "gem install sass" "SASS"
    execute "gem install git-up" "git-up"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   GEMs\n\n"

    install_gems

}

main
