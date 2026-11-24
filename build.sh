#!/usr/bin/env bash
# Copies the site files into dist/ for Cloudflare Pages. The site lives at the
# repo root because the nightly SIF job commits sif/index.html there.
set -euo pipefail
cd "$(dirname "$0")"
rm -rf dist
rsync -a --exclude-from=.deployignore --exclude=.deployignore --exclude=build.sh ./ dist/
