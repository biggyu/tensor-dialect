add_llvm_executable(tensor-opt tensor-opt.cpp)

target_link_libraries(tensor-opt PRIVATE
    TensorOpsLib
    MLIRFuncDialect
    MLIRIR
    MLIROptLib
    MLIRTransforms
    MLIRSupport
)

set_target_properties(tensor-opt PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)