#!/usr/bin/env bash

set -euo pipefail

source libs/system_utils.sh

install_python_from_source() {
    echo "Installing Python from source..."

    wget https://www.python.org/ftp/python/3.12.2/Python-3.12.2.tgz
    tar zxfv Python-3.12.2.tgz
    rm Python-3.12.2.tgz
    cd Python-3.12.2
    ./configure --prefix="$HOME/.local/" --enable-optimizations --with-lto
    make
    make install
    cd ..
    rm -rf Python-3.12.2

    echo "Installing Python from source finished"
}

main() {
    install_python_from_source
}

main "$@"
