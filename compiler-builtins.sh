#!/bin/bash -x

cd $TMP

touch compiler-builtins.c
touch compiler-builtins.cpp

gcc -dM -E compiler-builtins.c
gcc -dM -E compiler-builtins.cpp

clang -dM -E compiler-builtins.c
clang -dM -E compiler-builtins.cpp

cl -c -nologo -Zc:preprocessor -PD compiler-builtins.c
cl -c -nologo -Zc:preprocessor -PD compiler-builtins.cpp

rm -f compiler-builtins.c
rm -f compiler-builtins.cpp

