#!/bin/bash

cat <<EOF

 Arch Linux Installation Script


EOF

declare -r GITHUB_REPOSITORY="srod/dotfiles-arch"

declare -r DOTFILES_ORIGIN="https://github.com/$GITHUB_REPOSITORY.git"
declare -r DOTFILES_UTILS_URL="https://raw.githubusercontent.com/$GITHUB_REPOSITORY/master/src/os/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare DOTFILES="$HOME/.dotfiles"

# ----------------------------------------------------------------------
# | Helper Functions                                                   |
# ----------------------------------------------------------------------

check_internet_connection() {
    if [ ping -q -w1 -c1 google.com &>/dev/null ]; then
        printf "Please check your internet connection";
        exit 0
    fi
}

download() {

    local url="$1"
    local output="$2"

    if command -v "curl" &> /dev/null; then

        curl -LsSo "$output" "$url" &> /dev/null
        #     │││└─ write output to file
        #     ││└─ show error messages
        #     │└─ don't show the progress meter
        #     └─ follow redirects

        return $?

    elif command -v "wget" &> /dev/null; then

        wget -qO "$output" "$url" &> /dev/null
        #     │└─ write output to file
        #     └─ don't show output

        return $?
    fi

    return 1

}

download_dotfiles() {

    local tmpFile=""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    print_in_blue "\n • Clone GitHub repository\n\n"

    if [ ! -d "$DOTFILES" ]; then
        execute \
            "git clone --quiet --recurse-submodules -j8 $DOTFILES_ORIGIN $DOTFILES" "Cloning in '$DOTFILES'"
    else
        ask_for_confirmation "'$DOTFILES' already exists, do you want to delete it?"
        if answer_is_yes; then
            rm -Rf $DOTFILES
            execute \
                "git clone --quiet --recurse-submodules -j8 $DOTFILES_ORIGIN $DOTFILES" "Cloning in '$DOTFILES'"
        fi
    fi

    print_result $? "Clone success" "true"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    cd "$DOTFILES/src/os" \
        || return 1

}

download_utils() {

    local tmpFile=""

    tmpFile="$(mktemp /tmp/XXXXX)"

    download "$DOTFILES_UTILS_URL" "$tmpFile" \
        && . "$tmpFile" \
        && rm -rf "$tmpFile" \
        && return 0

   return 1

}

update_system() {

    print_in_blue "\n • Update system\n\n"

    ask_for_confirmation "Your system must be updated first, do you want to?"
    if answer_is_yes; then
        execute \
            "sudo pacman -Syu" "Checking updates..."
    fi

}

# ----------------------------------------------------------------------
# | Main                                                               |
# ----------------------------------------------------------------------

main() {

    # Ensure that the following actions
    # are made relative to this file's path.

    cd "$(dirname "${BASH_SOURCE[0]}")" \
        || exit 1

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    check_internet_connection

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Load utils

    if [ -a "./src/os/utils.sh" ]; then
        . "./src/os/utils.sh" || exit 1
    else
        download_utils || exit 1
    fi

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    ask_for_sudo

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    update_system

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    download_dotfiles

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    source ./create_symbolic_links.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    source ./create_local_config_files.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    source ./install/main.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    source ./set_ssh_key.sh

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    source ./restart.sh

}

main
