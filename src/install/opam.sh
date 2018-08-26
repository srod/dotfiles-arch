#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_opam() {

    brew_install "Brew Opam" "opam"
    execute "opam init" "Init"
    execute "opam update" "Update"
    execute "opam upgrade" "Upgrade"
    execute "opam install patdiff" "Install Patdiff"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   OPAM\n\n"

    install_opam

}

main