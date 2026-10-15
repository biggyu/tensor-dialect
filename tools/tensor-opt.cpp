#include "TensorOps.h"

#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/IR/DialectRegistry.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"
#include "mlir/Transforms/Passes.h"

int main(int argc, char **argv) {
    mlir::registerTransformsPasses();

    mlir::DialectRegistry registry;
    registry.insert<tensor_ops::TensorDialect, mlir::func::FuncDialect>();
    return mlir::asMainReturnCode(
        mlir::MlirOptMain(argc, argv, "Tensor dialect optimizer\n", registry)
    );
}