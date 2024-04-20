#!/usr/bin/env bash

set -euo pipefail

source libs/system_utils.sh

install_chrome() {
    echo "Installing Chrome ..."

    if is_installed google-chrome-stable; then
        echo "Chrome already installed"
        return 0
    fi

    apt-get install libxss1 libappindicator1 libindicator7 -qq -y
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --directory-prefix /tmp
    apt-get install /tmp/google-chrome*.deb

    echo "Installing Chrome finished"
}

main() {
    install_chrome
}

main "$@"
