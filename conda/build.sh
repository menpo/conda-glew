#!/bin/bash

export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

cd build

mkdir build_glew
cd build_glew
cmake ../cmake -DCMAKE_INSTALL_PREFIX=$PREFIX -DCMAKE_BUILD_TYPE=Release -DBUILD_UTILS=0 -DGLEW_OSMESA=1
make -j2
make install

cd ..
mkdir build_test
cd build_test
cmake ../cmake/testbuild -DCMAKE_INSTALL_PREFIX=${PWD}/out -DCMAKE_PREFIX_PATH=${PWD}/out -DCMAKE_BUILD_TYPE=Release
make -j2
make install

# Copy the libs just for testing
if [ "$(uname -s)" == "Darwin" ]; then
  cp $PREFIX/lib/libGLEW.dylib out/bin/
else
  patchelf --set-rpath '$ORIGIN/./' $PREFIX/lib/libGLEW.so
  patchelf --set-rpath $PREFIX/lib out/bin/cmake-test
fi
out/bin/cmake-test
