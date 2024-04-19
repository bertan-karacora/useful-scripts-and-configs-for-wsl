#!/usr/bin/env bash

set -euo pipefail

source libs/io_utils.sh

# If you are using a dedicated Nvidia card this is a solution to a common problem with OpenGL.
# The effect can be tested e.g. using glxgears.
fix_gpu_selection() {
    local string_bashrc="
# Fix OpenGL rendering
export MESA_D3D12_DEFAULT_ADAPTER_NAME=NVIDIA"

    echo "Fix GPU selection ..."

    append_if_not_contained ~/.bashrc "$string_bashrc"

    echo "Fix GPU selection finished"
}

main() {
    fix_gpu_selection
}

main "$@"
