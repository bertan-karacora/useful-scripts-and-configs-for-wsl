#!/usr/bin/env bash

set -euo pipefail

username=""

read_username() {
    echo "Username: "
    read -r username
}

generate_sshkey() {
    local email=""
    local path_key_windows="/mnt/c/Users/$username/.ssh/id_ed25519"

    echo "Generating SSH keys ..."

    if [[ -f $path_key_windows ]]; then
        echo "Key already exists at: $path_key_windows"
        return 0
    fi

    echo "Your email: "
    read -r email
    ssh-keygen -t ed25519 -C "$email" -f "$path_key_windows"

    echo "Generating SSH keys finished"
}

copy_keys() {
    echo "Copying SSH keys to WSL..."

    cp -r "/mnt/c/Users/$username/.ssh/id_"* /home/$username/.ssh
    chmod 600 /home/$username/.ssh/id_*

    echo "Copying SSH keys to WSL finished"
}

setup_ssh() {
    echo "Configuring SSH ..."

    generate_sshkey
    copy_keys

    echo "Configuring SSH finished"
}

main() {
    read_username
    setup_ssh
}

main "$@"
