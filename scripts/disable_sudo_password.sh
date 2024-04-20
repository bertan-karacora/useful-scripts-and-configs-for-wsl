#!/usr/bin/env bash

set -euo pipefail

source libs/io_utils.sh

username=""

read_username() {
    echo "Username: "
    read -r username
}

disable_sudo_password() {
    local file="/etc/sudoers.d/$username"
    local entry="$username ALL=(ALL) NOPASSWD:ALL"

    echo "Disabling password for user $username in file $file ..."

    if contains "$file" "$entry"; then
        echo "Sudo password for user $username already disabled"
        return 0
    fi

    echo "$entry" | EDITOR='tee -a' visudo --quiet --file="$file" >/dev/null
    echo "Disabling password finished"
}

main() {
    read_username
    disable_sudo_password
}

main "$@"
