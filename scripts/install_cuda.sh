#!/usr/bin/env bash

set -euo pipefail

source libs/system_utils.sh

remove_gpg_key() {
    # Reference: https://docs.nvidia.com/cuda/wsl-user-guide/index.html
    apt-key del 7fa2af80
}

cleanup() {
    rm cuda*.deb
}

# Reference (check for newer versions manually, there is no "latest"):
# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_local
install_cuda() {
    echo "Installing Cuda ..."

    if is_installed cuda-toolkit-12-4; then
        echo "Cuda already installed"
        return 0
    fi

    remove_gpg_key

    wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin
    mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.4.1/local_installers/cuda-repo-wsl-ubuntu-12-4-local_12.4.1-1_amd64.deb
    dpkg -i cuda-repo-wsl-ubuntu-12-4-local_12.4.1-1_amd64.deb
    cp /var/cuda-repo-wsl-ubuntu-12-4-local/cuda-*-keyring.gpg /usr/share/keyrings/
    apt-get update -qq
    apt-get install cuda-toolkit-12-4 -y -qq

    cleanup

    echo "Installing Cuda finished"
}

main() {
    install_cuda
}

main "$@"
