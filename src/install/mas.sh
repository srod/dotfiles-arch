#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_mas() {

    if cmd_exists "mas"; then
        execute "mas install 1068435535" "Dr. Antivirus"
        execute "mas install 409183694" "Keynote"
        execute "mas install 1133028347" "Dr. Cleaner Pro Plus"
        execute "mas install 568494494" "Pocket"
        execute "mas install 557168941" "Tweetbot"
        execute "mas install 409201541" "Pages"
        execute "mas install 880001334" "Reeder"
        execute "mas install 409203825" "Numbers"
        execute "mas install 681812329" "iCompta"
        execute "mas install 1153157709" "Speedtest"
    else
        print_result $? "mas must be installed with homebrew"
    fi

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   Mac App Store\n\n"

    install_mas

}

main