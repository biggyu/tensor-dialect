rm -rf build
mkdir build

cmake -S . -B build -G Ninja \
    -DLLVM_DIR="$HOME/llvm21-mlir-install/lib/cmake/llvm" \
    -DMLIR_DIR="$HOME/llvm21-mlir-install/lib/cmake/mlir" \
    -DCMAKE_BUILD_TYPE=Debug
cd build
ninja tensor-opt

# cmake --build build --target tensor-opt
