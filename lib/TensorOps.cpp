#include "mlir/IR/BuiltinDialect.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/DialectImplementation.h"
#include "mlir/IR/PatternMatch.h"

#include "TensorOps.h"

using namespace mlir;
using namespace tensor_ops;

namespace {
#include "TensorOpsPatterns.h.inc"
}

void TensorDialect::initialize() {
    addOperations<
#define GET_OP_LIST
#include "TensorOps.cpp.inc"
    >();
}

mlir::LogicalResult tensor_ops::ConstantOp::verify() {
    auto resultType = llvm::cast<mlir::RankedTensorType>(getResult().getType());
    auto attrType = getValue().getType();
    if (resultType != attrType) {
        return emitOpError("result type must match attribute type");
    }
    return mlir::success();
}

void tensor_ops::ConstantOp::build(mlir::OpBuilder &builder, mlir::OperationState &state, double value) {
    auto type = mlir::RankedTensorType::get({}, builder.getF64Type());
    auto attr = mlir::DenseElementsAttr::get(type, llvm::ArrayRef<double>{value});
    build(builder, state, attr);
}

mlir::LogicalResult tensor_ops::MatMulOp::verify() {
    auto lhsType = llvm::cast<mlir::RankedTensorType>(getLhs().getType());
    auto rhsType = llvm::cast<mlir::RankedTensorType>(getRhs().getType());
    
    if (lhsType.getRank() != 2 || rhsType.getRank() != 2) {
        return emitOpError("expects 2D tensor operands");
    }
    if (lhsType.getDimSize(1) != rhsType.getDimSize(0)) {
        return emitOpError("inner dimensions must match: ") << lhsType.getDimSize(1) << " vs " << rhsType.getDimSize(0);
    }
    return mlir::success();
}

mlir::LogicalResult tensor_ops::AddOp::verify() {
    auto lhsType = llvm::cast<mlir::RankedTensorType>(getLhs().getType());
    auto rhsType = llvm::cast<mlir::RankedTensorType>(getRhs().getType());

    if (lhsType.getShape() != rhsType.getShape()) {
        return emitOpError("operand shapes must match");
    }
    return mlir::success();
}

mlir::LogicalResult tensor_ops::ReluOp::verify() {
    auto inputType = llvm::dyn_cast<mlir::RankedTensorType>(getInput().getType());

    if (!inputType) {
        return emitOpError("expects a ranked tensor");
    }
    return mlir::success();
}

void tensor_ops::ReluOp::getCanonicalizationPatterns(RewritePatternSet &result, MLIRContext *context) {
    result.add<ReluReluOptPattern>(context);
}

#define GET_OP_CLASSES
#include "TensorOps.cpp.inc"
#include "TensorOpsDialect.cpp.inc"
