#!/usr/bin/env bash

set -euo pipefail

source libs/io_utils.sh

username=""
readonly name_repo="useful-scripts-and-configs-for-wsl"

read_username() {
    echo "Username: "
    read -r username
}

setup_libs() {
    local string_bash_libs="$(<bash_libs.sh)"
    local string_bashrc="
if [ -f ~/.bash_libs ]; then
    . ~/.bash_libs
fi"

    echo "Setting up bash functions ..."

    append_if_not_contained "/home/$username/.bash_libs" "$string_bash_libs"
    append_if_not_contained "/home/$username/.bashrc" "$string_bashrc"

    echo "Setting up bash functions finished"
}

setup_aliases() {
    local string_bash_aliases="$(<bash_aliases.sh)"
    local string_bashrc="
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi"

    echo "Setting up bash aliases ..."

    append_if_not_contained "/home/$username/.bash_aliases" "$string_bash_aliases"
    append_if_not_contained "/home/$username/.bashrc" "$string_bashrc"

    echo "Setting up bash aliases finished"

}

setup_scripts() {
    local string_bashrc="
export PATH=\$PATH:~/$name_repo/scripts"

    echo "Setting up scripts ..."

    append_if_not_contained "/home/$username/.bashrc" "$string_bashrc"

    echo "Setting up scripts finished"
}

setup_packages() {
    echo "Installing packages ..."

    cat requirements_apt.txt |
        xargs sudo apt-get install -y -qq

    echo "Installing packages finished"
}

setup() {
    local venv="$(systemd-detect-virt)"

    if [[ "$venv" != "wsl" ]]; then
        echo "This script is only for WSL"
        exit 1
    fi

    setup_libs
    setup_aliases
    setup_scripts
    setup_packages

    ./scripts/disable_sudo_password.sh
    ./scripts/disable_apt_marketing_message.sh
    ./scripts/fix_gpu_selection.sh
    ./scripts/setup_git.sh
    ./scripts/setup_ssh.sh
    ./scripts/install_cuda.sh
    ./scripts/install_chrome.sh
}

main() {
    read_username
    setup
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
    main "$@"
fi
