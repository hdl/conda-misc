#!/bin/bash

# binutils build
set -e
set -x


cd wishbone-tool
export CARGO_TARGET_X86_64_UNKNOWN_LINUX_GNU_LINKER="$CC"
cargo build --release

install -d $PREFIX/bin
install target/release/wishbone-tool $PREFIX/bin
