#!/bin/sh

INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-.}"
OUTPUT_DIR="${OUTPUT_DIR%/}"

# Generate all tex files
find "${INPUT_DIR}" -type f -name "*.json" | while read file; do
    filename=$(basename -- "${file}")
    filename="${filename%.*}"
    output_file="${OUTPUT_DIR}/${filename}.tex"
    args="gen_cv.py ${file} templates/jakes_resume.tex.jinja2 ${output_file}"
    echo "Build .tex { input: ${file}, output: ${output_file}} }"
    if type "uv" > /dev/null; then
        uv run ${args}
    else
        python3 ${args}
    fi
done