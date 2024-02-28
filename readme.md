
# Reverse FFI with Mathlib

  This project demonstrates how to call lean code from C/C++. Main lean repository already contains an [[example][https://github.com/leanprover/lean4/tree/master/src/lake/examples/reverse-ffi]] project. Unfortunately, when your lean project depends on std or mathlib the setup gets more complicated and this repository demonstrates how to do that.
  


```
lake update
lake build Aesop:shared Cli:shared ImportGraph:shared Mathlib:shared ProofWidgets:shared Qq:shared Std:shared
lake build
export LIBRARY_PATH=$(pwd)/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.elan/toolchains/leanprover--lean4---v4.6.0-rc1/lib/lean/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/aesop/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Cli/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/importGraph/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/mathlib/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/proofwidgets/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Qq/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/std/.lake/build/lib/
export LD_LIBRARY_PATH=$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/.elan/toolchains/leanprover--lean4---v4.6.0-rc1/include/
g++ test.cpp -o test -lreverseffiwithmathlib
./test
```
