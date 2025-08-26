#!/bin/sh

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-.}"

# Build all PDF files
find "${INPUT_DIR}" -type f -name "*.tex" | while read file; do
    echo "Build PDF for $file"
    latexmk -interaction=nonstopmode -file-line-error -pdf -halt-on-error -shell-escape -outdir="${OUTPUT_DIR}" ${file}
done
