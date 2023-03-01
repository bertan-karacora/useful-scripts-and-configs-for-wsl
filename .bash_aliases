alias sudo="sudo "

function rzi {
	find . -name "*:Zone.Identifier" -type f -delete
}

function compress_pdfs {
	find . -type f -size +1M -name "*.pdf" -exec sh -c 'gs -sDEVICE=pdfwrite -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$1.compressed" "$1" && mv "$1.compressed" "$1"' sh {} \;
}

function merge_pdfs {
	gs -sDEVICE=pdfwrite -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -sOutputFile="$1.merged" "$@"  > /dev/null
	mv "$1.merged" "$1"
}
