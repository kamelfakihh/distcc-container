#!/usr/bin/env bash

set -euo pipefail

LLVM_VERSION=19.1.0
INSTALL_PREFIX=/usr
TARGETS_TO_BUILD="X86;ARM;AArch64"

# check if root
# if [[ $EUID -ne 0 ]]; then
#   echo "ERROR: Please run as root (or with sudo)"
#   exit 1
# fi

# NOTE: probably incomplete
sudo apt update
sudo apt install -y \
  build-essential \
  cmake \
  ninja-build \
  python3 \
  ca-certificates \
  git

if [ -d "tmp/llvm-src" ]; then
    echo "ERROR: llvm-src already exists, remove it and try again"
    exit 1
fi

git clone https://github.com/llvm/llvm-project.git \
  --depth 1 \
  --branch llvmorg-$LLVM_VERSION \
  tmp/llvm-src

cd tmp/llvm-src
mkdir -p build

cmake -G Ninja \
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS="clang;lld;lldb" \
  -DLLVM_TARGETS_TO_BUILD=$TARGETS_TO_BUILD \
  -DCMAKE_INSTALL_PREFIX="$INSTALL_PREFIX" \
  -S llvm \
  -B build

cmake --build build
DESTDIR="$PWD/../llvm"  cmake --build build --target install