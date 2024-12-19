#!/bin/sh

# Generate all tex files
find data/ -type f -name "*.json" | while read file; do
    echo "Generate .tex for $file"
    filename=$(basename -- "${file}")
    echo "${filename}"
    filename="${filename%.*}"
    echo "${filename}"
    python gen_cv.py ${file} templates/jakes_resume.tex.jinja2 "${filename}.tex"
done