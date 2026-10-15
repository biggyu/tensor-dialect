add_mlir_library(TensorOpsLib
    TensorOps.cpp

    DEPENDS
    MLIRTensorOpsIncGen
    MLIRTensorOpsPatternsIncGen

    LINK_LIBS PUBLIC
    MLIRIR
    MLIRPass
    MLIRTransforms
    MLIRSupport
)