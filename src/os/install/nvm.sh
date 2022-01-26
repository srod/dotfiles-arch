#!/bin/bash

declare -r LOCAL_SHELL_CONFIG_FILE="$HOME/.bash.local"
declare -r NVM_DIRECTORY="$HOME/.nvm"
declare -r NVM_GIT_REPO_URL="https://github.com/creationix/nvm.git"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

add_nvm_configs() {

    declare -r CONFIGS="
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Node Version Manager
export NVM_DIR=\"$NVM_DIRECTORY\"
[ -f \"\$NVM_DIR/nvm.sh\" ] \\
    && . \"\$NVM_DIR/nvm.sh\"
[ -f \"\$NVM_DIR/bash_completion\" ] \\
    && . \"\$NVM_DIR/bash_completion\"
"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    execute \
        "printf '%s' '$CONFIGS' >> $LOCAL_SHELL_CONFIG_FILE \
            && . $LOCAL_SHELL_CONFIG_FILE" \
        "nvm (update $LOCAL_SHELL_CONFIG_FILE)"

}

install_node() {

    # Install the latest stable version of Node
    # (this will also set it as the default).

    execute \
        ". $LOCAL_SHELL_CONFIG_FILE \
            && nvm install $1 \
            && npm install npm@8 -g" \
        "nvm (install Node $1)"
}

install_nvm() {

    # Install `nvm` and add the necessary
    # configs in the local shell config file.

    execute \
        "git clone --quiet $NVM_GIT_REPO_URL $NVM_DIRECTORY" \
        "nvm (install)" \
    && add_nvm_configs

}

update_nvm() {

    execute \
        "cd $NVM_DIRECTORY \
            && git fetch --quiet origin \
            && git checkout --quiet \$(git describe --abbrev=0 --tags) \
            && . $NVM_DIRECTORY/nvm.sh" \
        "nvm (upgrade)"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_blue "\n   NVM\n\n"

    if [ ! -d "$NVM_DIRECTORY" ]; then
        install_nvm
    else
        update_nvm
    fi

    install_node 16

}

main
