#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
  EXTRA_ARGS="-DCMAKE_MACOSX_RPATH=1"
else
  EXTRA_ARGS=""
fi

export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

cd build

# Build Glew itself
mkdir build_glew
cd build_glew
cmake ../cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DBUILD_UTILS=1 $EXTRA_ARGS
make
make install

# Build the tests
cd ..
mkdir build_test
cd build_test
cmake ../cmake/testbuild -DCMAKE_INSTALL_PREFIX=${PWD}/out -DCMAKE_PREFIX_PATH=${PWD}/out -DCMAKE_BUILD_TYPE=Release $EXTRA_ARGS
make
make install

# Copy the libs just for testing
if [[ "$OSTYPE" == "darwin"* ]]; then
  DYLD_LIBRARY_PATH="$PREFIX/lib" out/bin/cmake-test
else
  LD_LIBRARY_PATH="$PREFIX/lib" out/bin/cmake-test
fi
