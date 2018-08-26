#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

generate_ssh_keys() {

    ask "Please provide an email address: " && printf "\n"
    ssh-keygen -t rsa -b 4096 -C "$(get_answer)" -f "$1"

    print_result $? "Generate SSH keys"

}

set_ssh_key() {

    local sshKeyFileName="$HOME/.ssh/id_rsa"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If there is already a file with that
    # name, generate another, unique, file name.

    if [ -f "$sshKeyFileName" ]; then
        sshKeyFileName="$(mktemp -u "$HOME/.ssh/id_rsa_XXXXX")"
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    generate_ssh_keys "$sshKeyFileName"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n • Set up SSH keys\n\n"

    set_ssh_key

    print_result $? "Set up SSH keys"

}

main