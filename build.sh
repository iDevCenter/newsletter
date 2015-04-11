#!/usr/bin/env sh

echo "Building newsletter..."

wintersmith build --quiet --chdir generator --clean --output ../build

echo "Building newsletter done."