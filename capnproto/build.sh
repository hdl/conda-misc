#!/bin/bash

set -x

mkdir build
cd build

declare -a CMAKE_PLATFORM_FLAGS
if [[ ${HOST} =~ .*darwin.* ]]; then
    CMAKE_PLATFORM_FLAGS+=(-DCMAKE_OSX_SYSROOT="${CONDA_BUILD_SYSROOT}")
    # "-stdlib=libc++ -mmacosx-version-min=10.7" are required to enable C++11 features
    #CMAKE_CXX_FLAGS="$CMAKE_CXX_FLAGS -stdlib=libc++ -mmacosx-version-min=10.7"
    #EXTRA_CMAKE_ARGS="-DCMAKE_OSX_DEPLOYMENT_TARGET=10.7"
    # Disable testing on OS X due to CMake config bugs fixed only in master:
    # https://github.com/sandstorm-io/capnproto/issues/322
    EXTRA_CMAKE_ARGS="$EXTRA_CMAKE_ARGS -DBUILD_TESTING=OFF -DCMAKE_CXX_COMPILE_FEATURES=cxx_constexpr"
fi

cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX="$PREFIX" \
    -DCMAKE_INSTALL_LIBDIR="lib" \
    $EXTRA_CMAKE_ARGS \
    ../c++

cmake --build . -- -j ${CPU_COUNT}

if [ "$(uname)" != "Darwin" ]; then
    cmake --build . --target check
fi

cmake --build . --target install
