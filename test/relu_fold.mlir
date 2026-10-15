func.func @test(%arg0: tensor<?x?xf64>) -> tensor<?x?xf64> {
    %0 = tensor_ops.relu %arg0 : tensor<?x?xf64> -> tensor<?x?xf64>
    %1 = tensor_ops.relu %0 : tensor<?x?xf64> -> tensor<?x?xf64>
    return %1 : tensor<?x?xf64>
}