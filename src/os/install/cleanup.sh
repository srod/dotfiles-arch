#!/bin/bash

print_in_blue "\n   Cleanup\n\n"

execute ". $LOCAL_SHELL_CONFIG_FILE" "Load env"

execute \
    "rm -rf $HOME/.bash.local" \
    "Remove local bash"
