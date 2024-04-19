set -a

replace_spaces_filename() {
    local path="$1"
    local path_dirname="$(dirname "$path")"
    local path_basename="$(basename "${path//' '/'_'}")"

    echo "$path"

    mv "$path" "$path_dirname/$path_basename" --verbose
}

replace_spaces_filenames() {
    find . -name "* *" -print0 |
        sort --reverse --zero-terminated |
        xargs --null --replace={} bash -c 'replace_spaces_filename "$@"' -- {}
}
