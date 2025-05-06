#!/bin/sh

# Build all PDF files
find "${1:-.}" -type f -name "*.tex" | while read file; do
    echo "Build PDF for $file"
    latexmk -interaction=nonstopmode -file-line-error -pdf -halt-on-error -shell-escape -outdir="${2:-.}" ${file}
done
