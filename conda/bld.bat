cd build


md build_glew
cd build_glew

cmake .. -G"NMake Makefiles" ^
 -DCMAKE_BUILD_TYPE=Release ^
 -DBUILD_SHARED_LIBS=1 ^
 -DBUILD_UTILS=1 ^
 -DGLEW_OSMESA=1 ^
 -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX%

cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
if errorlevel 1 exit 1

cd ..

md build_test
cd build_test

cmake ../cmake/testbuild -G"NMake Makefiles" ^
  -DCMAKE_BUILD_TYPE=Release
  -DCMAKE_INSTALL_PREFIX=${PWD}/out ^
  -DCMAKE_PREFIX_PATH=${PWD}/out ^

cmake --build . --config Release --target ALL_BUILD
cmake --build . --config Release --target INSTALL
if errorlevel 1 exit 1

cp %LIBRARY_LIB%/libGLEW.dll .
cp %LIBRARY_LIB%/libOSMesa.dll .
out/bin/cmake-test
if errorlevel 1 exit 1
