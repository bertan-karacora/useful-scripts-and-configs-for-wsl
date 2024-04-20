#!/usr/bin/env bash

set -euo pipefail

source libs/system_utils.sh

readonly path_credential_manager_windows="/mnt/c/Program Files/Git/mingw64/bin/git-credential-manager.exe"
readonly rebase_recommended="true"
readonly defaultbranch_recommended="main"
readonly editor_recommended="code --wait"
readonly autocrlf_recommended="input"

install_git() {
    echo "Installing Git ..."

    if is_installed git; then
        echo "Git already installed"
    fi

    apt-get install git -qq
    echo "Installing Git finished"
}

configure_git_name() {
    local name=""
    local name_git="$(git config --global user.name)"

    if [[ "$name_git" ]]; then
        echo "Git name already set: $name_git"
        return 0
    fi

    echo "Your name: "
    read -r name
    git config --global user.name "$name"
}

configure_git_email() {
    local email=""
    local email_git="$(git config --global user.email)"

    if [[ "$email_git" ]]; then
        echo "Git email already set: $email_git"
        return 0
    fi

    echo "Your email: "
    read -r email
    git config --global user.email "$email"
}

configure_credential_helper_windows() {
    if [[ -f "$path_credential_manager_windows" ]]; then
        git config --global credential.helper "$path_credential_manager_windows"
        echo "Git credential manager found in Windows: $path_credential_manager_windows"
    fi
}

ask_yesno() {
    while true; do
        read -p "Do you wish to use the recommended settings? " yesno
        case $yesno in
        [Yy]*)
            return 0
            ;;
        [Nn]*)
            return 1
            ;;
        *)
            echo "Please answer yes or no."
            ;;
        esac
    done
}

configure_behavior() {
    if ask_yesno; then
        git config --global pull.rebase "$rebase_recommended"
        git config --global init.defaultBranch "$defaultbranch_recommended"
        git config --global core.editor "$editor_recommended"
        git config --global core.autocrlf "$autocrlf_recommended"
    fi
}

configure_git() {
    echo "Configuring Git ..."

    configure_git_name
    configure_git_email
    configure_credential_helper_windows
    configure_behavior

    echo "Configuring Git finished"
}

main() {
    install_git
    configure_git
}

main "$@"
