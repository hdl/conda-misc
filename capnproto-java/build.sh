#! /bin/bash

set -e
set -x

patch Makefile fix.patch
make all
make install

