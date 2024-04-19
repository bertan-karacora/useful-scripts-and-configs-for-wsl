set -a

is_installed() {
    local packages="$@"
    local is_installed=""

    for package in $packages; do
        is_installed="$(dpkg-query --show --showformat='${db:Status-Status}\n' "$package" 2>/dev/null)"
        if [[ "$is_installed" != "installed" ]]; then
            false
            return
        fi
    done

    true
}
