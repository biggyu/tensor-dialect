include "mlir/IR/PatternBase.td"
include "TensorOps.td"
def ReluReluOptPattern : Pat<
    (ReluOp (ReluOp $arg)), 
    (ReluOp $arg)
>;

// def TypesAreIdentical : Constraint<
//     CPred<"$0.getType() == $1.getType()">
// >;

// def RedundantReluOptPattern : Pat<
//     (ReluOp:$res $arg), (replaceWithValue $arg),
//     [(TypesAreIdentical $res, $arg)]
// >;