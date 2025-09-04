FROM ghcr.io/astral-sh/uv:python3.8-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /home

RUN apt update
RUN apt install -y latexmk texlive texlive-latex-extra

COPY gen_cv.py pyproject.toml uv.lock /home/
RUN uv sync

COPY build_tex.sh /usr/bin/buildtex
COPY build_pdf.sh /usr/bin/buildpdf
RUN chmod u+x /usr/bin/buildpdf /usr/bin/buildtex
