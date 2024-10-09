#!/bin/bash


# download all dependencies
lake update

# build shared libraries of all dependencies
lake build Aesop:shared Cli:shared ImportGraph:shared Mathlib:shared ProofWidgets:shared Qq:shared Batteries:shared LeanSearchClient:shared

# get current version of lean
export LEAN_VERSION=`cat lean-toolchain` && export LEAN_VERSION=${LEAN_VERSION:17}

# convert `libLean.a` to `libLean.so`
mkdir -p .lake/build
g++ -shared -o .lake/build/libLean.so -Wl,--whole-archive -fvisibility=default $HOME/.elan/toolchains/leanprover--lean4---${LEAN_VERSION}/lib/lean/libLean.a -Wl,--no-whole-archive

# build project
lake build

# set up enviroment variables
export LIBRARY_PATH=$(pwd)/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$HOME/.elan/toolchains/leanprover--lean4---${LEAN_VERSION}/lib/lean/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/aesop/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Cli/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/importGraph/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/mathlib/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/proofwidgets/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/Qq/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/batteries/.lake/build/lib/
export LIBRARY_PATH=$LIBRARY_PATH:$(pwd)/.lake/packages/LeanSearchClient/.lake/build/lib/
export LD_LIBRARY_PATH=$LIBRARY_PATH
export CPLUS_INCLUDE_PATH=$HOME/.elan/toolchains/leanprover--lean4---${LEAN_VERSION}/include/

# build C++ file calling Lean functions
g++ test.cpp -o test -lleanshared -lreverseffiwithmathlib

# run 
./test
