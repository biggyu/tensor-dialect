include "mlir/IR/OpBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

def Tensor_Dialect : Dialect {
    let name = "tensor_ops";

    // let sumamry = "A dialect for tensor matmul, add, and relu";

    // let description = [{}]

    let cppNamespace = "tensor_ops";
}

class Tensor_Op<string mnemonic, list<Trait> traits = [] > :
    Op<Tensor_Dialect, mnemonic, traits>;

def ConstantOp : Tensor_Op<"constant"> {
    let arguments = (ins F64ElementsAttr:$value);

    let results = (outs F64Tensor:$result);
    let assemblyFormat = "attr-dict `:` type($result)";
    // let hasCustomAssemblyFormat = 0;
    let hasVerifier = 1;

    let builders = [
        // different type of builder that has different ins
        OpBuilder<(ins "::mlir::DenseElementsAttr":$value), [{
            build($_builder, $_state, value.getType(), value);
        }]>,

        OpBuilder<(ins "double":$value)>
    ];
}
def MatMulOp : Tensor_Op<"matmul"> {
    // let summary = "";
    // let description = [{}];
    // let arguments = (ins F64Tensor, F64Tensor); -> wrong
    let arguments = (ins F64Tensor:$lhs, F64Tensor:$rhs);

    let results = (outs F64Tensor:$result);

    let hasVerifier = 1;
    let assemblyFormat = "$lhs `,` $rhs attr-dict `:` type($lhs) `,` type($rhs) `->` type($result)";
}
def AddOp : Tensor_Op<"add"> {
    // let summary = "";
    // let description = [{}];
    // let arguments = (ins F64Tensor, F64Tensor);
    let arguments = (ins F64Tensor:$lhs, F64Tensor:$rhs);

    let results = (outs F64Tensor:$result);

    let hasVerifier = 1;
    let assemblyFormat = "$lhs `,` $rhs attr-dict `:` type($lhs) `,` type($rhs) `->` type($result)";
}
def ReluOp : Tensor_Op<"relu", [Pure]> {
    // let summary = "";
    // let description = [{}];
    // let arguments = (ins F64Tensor);
    let arguments = (ins F64Tensor:$input);

    let results = (outs F64Tensor:$result);

    let hasVerifier = 1;
    let hasCanonicalizer = 1;
    //match with $result above
    let assemblyFormat = "$input attr-dict `:` type($input) `->` type($result)";
}

def PrintOp : Tensor_Op<"print"> {
    let arguments = (ins F64Tensor:$input);
    let assemblyFormat = "$input attr-dict `:` type($input)";
}