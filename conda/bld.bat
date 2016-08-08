@echo on

cd build

md build_glew
cd build_glew

cmake ../cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=1 -DBUILD_UTILS=1 -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"

nmake install
if errorlevel 1 exit 1

cd ..

md build_test
cd build_test

cmake ../cmake/testbuild -G"NMake Makefiles" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="%LIBRARY_PREFIX%" -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"

nmake install
if errorlevel 1 exit 1

"%LIBRARY_BIN%\cmake-test.exe"
if errorlevel 1 exit 1
del "%LIBRARY_BIN%\cmake-test.exe"
exit 0
