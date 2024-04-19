set -a

remove_metadata_pdf() {
    gs \
        -sDEVICE=pdfwrite \
        -dPDFSETTINGS=/default \
        -dQUIET \
        -o "$1.withoutMetadata" \
        "$1" \
        -c "[ /Title () /Author () /Keywords () /Subject () /DOCINFO pdfmark"
    mv "$1.withoutMetadata" "$1"

    echo "Removed metadata from $1."
}

remove_metadata_pdfs() {
    find . -type f -name "*.pdf" -print0 |
        xargs --null --replace={} bash -c 'remove_metadata_pdf "$@"' -- {}
}

merge_pdfs() {
    gs \
        -sDEVICE=pdfwrite \
        -dPDFSETTINGS=/default \
        -dQUIET \
        -o "$1.merged" \
        "$@" >/dev/null
    mv "$1.merged" "$1"

    echo "Merged into $1."
}

compress_pdf() {
    gs \
        -sDEVICE=pdfwrite \
        -dPDFSETTINGS=/default \
        -dQUIET \
        -o "$1.compressed" \
        "$1"
    mv "$1.compressed" "$1"

    echo "Compressed $1."
}

compress_pdfs() {
    find . -type f -name "*.pdf" -size +1M -print0 |
        xargs --null --replace={} bash -c 'compress_pdf "$@"' -- {}
}

fix_pdfs() {
    replace_filename_spaces
    compress_pdfs
    remove_metadata_pdfs
}
