
# Reverse FFI with Mathlib

  This project demonstrates how to call lean code from C/C++. Main lean repository already contains an [example](https://github.com/leanprover/lean4/tree/master/src/lake/examples/reverse-ffi) project. Unfortunately, when your lean project depends on std or mathlib the setup gets more complicated and this repository demonstrates how to do that.
  

To build this repository run these commands
```
lake update
lake build Aesop:shared Cli:shared ImportGraph:shared Mathlib:shared ProofWidgets:shared Qq:shared Batteries:shared LeanSearchClient
g++ -shared -o .lake/build/libLean.so -Wl,--whole-archive -fvisibility=default $HOME/.elan/toolchains/leanprover--lean4---v4.13.0-rc3/lib/lean/libLean.a -Wl,--no-whole-archive
lake build
export LIBRARY_PATH=$(pwd)/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.elan/toolchains/leanprover--lean4---v4.13.0-rc3/lib/lean/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/aesop/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Cli/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/importGraph/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/mathlib/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/proofwidgets/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Qq/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/batteries/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/LeanSearchClient/.lake/build/lib/
export LD_LIBRARY_PATH=$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/.elan/toolchains/leanprover--lean4---v4.13.0-rc3/include/
g++ test.cpp -o test -lleanshared -lreverseffiwithmathlib
./test
```

Let me explain what is going on:

First we download all dependencies by
```
lake update
```

Next we need to build all the dependencies and create their shared libraries
```
lake build Aesop:shared Cli:shared ImportGraph:shared Mathlib:shared ProofWidgets:shared Qq:shared Std:shared
```
This takes some time but luckily has to be done only once.

To build our project run standard `lake build`.

Now we have all the pieces to build test program `test.cpp` which uses the function `minNumber` defined in `ReverseFFIwithMathlib.lean`. The main difficulty is to tell the compiler where to find all the necessary pieces.

To tell the linker where to find all the shared libraries we set `LIBRARY_PATH` with
```
export LIBRARY_PATH=$(pwd)/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.elan/toolchains/leanprover--lean4---v4.6.0-rc1/lib/lean/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/aesop/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Cli/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/importGraph/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/mathlib/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/proofwidgets/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Qq/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/std/.lake/build/lib/
```

To find these library when we run the program we set `LD_LIBRARY_PATH` to the same value
```
export LD_LIBRARY_PATH=$LIBRARY_PATH
```

Specify include path when compiling c++ program using Lean C API
```
export CPLUS_INCLUDE_PATH=$HOME/.elan/toolchains/leanprover--lean4---v4.6.0-rc1/include/
```

Compile `test.cpp`
```
g++ test.cpp -o test -lleanshared -lreverseffiwithmathlib
```
and run it
```
./test
```
