#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original submission (2021).
# Requires podman (or docker: export ENGINE=docker). Output: build/pc-npr.pdf
# src/ is copied to a scratch dir inside the container, since pdflatex converts orcid.eps (epstopdf) next to the sources.
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2021-historic
mkdir -p build
"$ENGINE" run --rm -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" "$IMAGE" \
  sh -c 'cp -r /src /tmp/src && cd /tmp/src && latexmk -pdf -interaction=nonstopmode -outdir=/out pc-npr.tex'
