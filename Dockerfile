FROM ubuntu:24.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt update
RUN apt install -y latexmk texlive-full

COPY build_pdf.sh /usr/bin/buildpdf
RUN chmod +x /usr/bin/buildpdf
