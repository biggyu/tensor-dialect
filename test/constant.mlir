// ConstantOp hasCustomAssemblyFormat=0
// func.func @test_constant() -> tensor<2x3xf64> {
//     %0 = "tensor_ops.constant"() {value = dense<[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]> : tensor<2x3xf64>} : () -> tensor<2x3xf64>
//     return %0 : tensor<2x3xf64>
// }

// ConstantOp assemblyFormat "attr-dict $value `:` type($result)" 
// ???

// ConstantOp assemblyFormat "attr-dict `:` type($result)"
func.func @test_constant() -> tensor<2x3xf64> {
    %0 = tensor_ops.constant {value = dense<[[1.0, 2.0, 3.0], [4.0, 5.0, 6.0]]> : tensor<2x3xf64>} : tensor<2x3xf64>
    return %0 : tensor<2x3xf64>
}