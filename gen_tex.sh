#!/bin/sh

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-.}"

# Generate all tex files
find "${INPUT_DIR}" -type f -name "*.json" | while read file; do
    echo "Generate .tex for $file"
    filename=$(basename -- "${file}")
    filename="${filename%.*}"
    python gen_cv.py ${file} templates/jakes_resume.tex.jinja2 "${OUTPUT_DIR}/${filename}"
done