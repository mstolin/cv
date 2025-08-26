#!/bin/sh

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-.}"
OUTPUT_DIR="${OUTPUT_DIR%/}"

# Generate all tex files
find "${INPUT_DIR}" -type f -name "*.json" | while read file; do
    filename=$(basename -- "${file}")
    filename="${filename%.*}"
    echo "Build .tex { input: ${file}, output: ${OUTPUT_DIR}/${filename} }"
    python3 gen_cv.py ${file} templates/jakes_resume.tex.jinja2 "${OUTPUT_DIR}/${filename}.tex"
done