# CV

This project is meant to automatically build my resume and deploy it online as a PDF.
You can use it as you want to build your own.

The idea is, that you define your resume in a structured format (`.json`) and a script (`.gen_cv.py`) generates a `.tex` file for you.
Afterward, you can build it, e.g. to PDF, as usual using _latexmk_.

An example is available at [_short.json_](./data/short.json), that contains four sections and three different styles.
The available template is based on [Jake's Resume](https://www.overleaf.com/latex/templates/jakes-resume/syzfjbzwjncs).

The workflow [_pdf.yml_](./.github/workflows/pdf.yml) automatically builds the PDF(s) and deploys them to github pages.
An example is available at [marcel.to/cv/short.pdf](https://marcel.to/cv/short.pdf).

## Requirements

- [Python](https://www.python.org/)
- [Tex Live](https://www.tug.org/texlive/) (use _texlive-full_ to guarantee that everything works)
- [Latexmk](https://ctan.org/pkg/latexmk/)

## Manual Build

1. Create and activate a virtual-env.
   ```sh
   python -m venv .venv
   source .venv/bin/activate
   ```
2. Install dependencies.
   ```sh
   pip install -r requirements.txt
   ```
3. Run the script to generate `.tex` files. Additionally, a build script is available at `gen_tex.sh`.
   ```sh
   python gen_cv.py data/short.json templates/jakes_resume.tex.jinja2 short.tex
   ```
4. Build the `.pdf` file. A build script is available at `build_pdf.sh`.
   ```sh
   latexmk -interaction=nonstopmode -file-line-error -pdf -halt-on-error -shell-escape -outdir=. short.tex
   ```
