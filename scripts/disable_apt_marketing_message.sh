#!/usr/bin/env bash

set -euo pipefail

disable_apt_marketing_message() {
    echo "Disabling apt marketing message ..."

    sed -i'' -e 's/^\(\s\+\)\([^#]\)/\1# \2/' /etc/apt/apt.conf.d/20apt-esm-hook.conf

    echo "Disabling apt marketing message finished"
}

main() {
    disable_apt_marketing_message
}

main "$@"
