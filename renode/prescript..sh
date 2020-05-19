#!/bin/bash

set -x

cd "$PACKAGE"

# Copy the recipe from the Renode's master
git clone --depth 1 https://github.com/renode/renode.git
mv renode/tools/packaging/conda/* .
rm -rf renode
rm README.rst

# Patch the recipe
function patch-func {
    if ! patch --no-backup-if-mismatch "$1" "$2"; then
        # Print the rejected part of the diff
        cat "$1.rej"
        exit -1
    fi
}

# Add Travis-specific patches for Renode repository files
patch-func meta.yaml meta_add_travis_patches.patch

# Build headless Renode on Linux and macOS (there's no Conda package with GtkSharp)
patch-func meta.yaml meta_headless_linux_and_osx.patch
patch-func build.sh build_without_gui.patch

# Clean the recipe
rm meta_add_travis_patches.patch
rm meta_headless_linux_and_osx.patch
rm build_without_gui.patch
rm prescript..sh
