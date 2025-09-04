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

-   Python via [uv](https://docs.astral.sh/uv/)
-   [Tex Live](https://www.tug.org/texlive/)
-   [Latexmk](https://ctan.org/pkg/latexmk/)

## Manual Build

1. Run the script to generate `.tex` files. Additionally, a build script is available at `build_tex.sh`.
    ```sh
    uv run gen_cv.py data/short.json templates/jakes_resume.tex.jinja2 build/short.tex
    # Or
    ./build_tex.sh data/ templates/jakes_resume.tex.jinja2 build/
    ```
2. Build the `.pdf` file. A build script is available at `build_pdf.sh`.
    ```sh
    latexmk -interaction=nonstopmode -file-line-error -pdf -halt-on-error -shell-escape -outdir=. short.tex
    # Or
    ./build_pdf.sh build/ pdf/
    ```

## Build using Docker Container

First, build the Docker container as `localhost/cv:latest`.

```sh
docker build --tag "localhost/cv:latest" .
```

Next, build the `.tex` and `.pdf` files.

```sh
docker run --rm -it \
  --mount type=bind,src=./data/,dst=/mnt/data/,ro \
  --mount type=bind,src=./templates/jakes_resume.tex.jinja2,dst=/mnt/templates/jakes_resume.tex.jinja2,ro \
  --mount type=bind,src=./tex/,dst=/mnt/tex/ \
  --mount type=bind,src=./pdf/,dst=/mnt/pdf/ \
  localhost/cv:latest \
  sh -c "buildtex /mnt/data /mnt/templates/jakes_resume.tex.jinja2 /mnt/tex && buildpdf /mnt/tex /mnt/pdf"
```
