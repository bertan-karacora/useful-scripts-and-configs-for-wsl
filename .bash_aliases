alias sudo="sudo "

function update {
	sudo apt update && sudo apt upgrade -y
}

function replace_filename_spaces {
	find . \
		-name "* *" \
		-print0 | \
	sort -rz | \
	xargs -0 -I{} \
	bash -c ' \
		mv \
			-v \
			"$1" "$(dirname "$1")/$(basename "${1// /_}")" \
	' -- {}
}

function compress_pdfs {
	find . \
		-type f \
		-name "*.pdf" \
		-size +1M \
		-print0 | \
	xargs -0 -I{} \
	bash -c '\
		gs \
			-sDEVICE=pdfwrite \
			-dPDFSETTINGS=/default \
			-dQUIET \
			-o "$1.compressed" \
			"$1" \
		&& mv "$1.compressed" "$1" \
		&& echo "Compressed $1." \
	' -- {}
}

function merge_pdfs {
	gs \
		-sDEVICE=pdfwrite \
		-dPDFSETTINGS=/default \
		-dQUIET \
		-o "$1.merged" \
		"$@" > /dev/null \
	&& mv "$1.merged" "$1" \
	&& echo "Merged into $1."
}

function remove_metadata_pdfs {
	find . \
		-type f \
		-name "*.pdf" \
		-print0 | \
	xargs -0 -I{} \
	bash -c '\
		gs \
			-sDEVICE=pdfwrite \
			-dPDFSETTINGS=/default \
			-dQUIET \
			-o "$1.withoutMetadata" \
			"$1" \
			-c "[ /Title () /Author () /Keywords () /Subject () /DOCINFO pdfmark" \
		&& mv "$1.withoutMetadata" "$1" \
		&& echo "Removed metadata from $1." \
	' -- {}
}

function fix_pdfs {
	replace_filename_spaces \
	&& compress_pdfs \
	&& remove_metadata_pdfs
}

function remove_zone_identifiers {
	find . \
		-type f \
		-name "*:Zone.Identifier" \
		-print \
		-delete
}

alias rzi="remove_zone_identifiers"
