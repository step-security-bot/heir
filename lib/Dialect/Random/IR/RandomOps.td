#ifndef LIB_DIALECT_RANDOM_IR_RANDOMOPS_TD_
#define LIB_DIALECT_RANDOM_IR_RANDOMOPS_TD_

include "lib/Dialect/Random/IR/RandomDialect.td"
include "lib/Dialect/Random/IR/RandomTypes.td"
include "mlir/IR/BuiltinAttributes.td"
include "mlir/IR/CommonTypeConstraints.td"
include "mlir/IR/OpBase.td"
include "mlir/Interfaces/InferTypeOpInterface.td"
include "mlir/Interfaces/SideEffectInterfaces.td"


class Random_Op<string mnemonic, list<Trait> traits = [Pure]> :
        Op<Random_Dialect, mnemonic, traits> {
  let cppNamespace = "::mlir::heir::random";
  let assemblyFormat = "operands attr-dict `:` functional-type(operands, results)";
}

def Random_InitOp : Random_Op<"init_prng"> {
  let summary = "Initializes the PRNG with a seed";
  let description = [{
    Initializes the PRNG with a seed.
  }];

  let arguments = (ins SignlessIntegerLike:$input);
  let results = (outs PRNG:$output);
}

def Random_DiscreteGaussianDistributionOp : Random_Op<"discrete_gaussian_distribution"> {
  let summary = "Initializes the Discrete Gaussian Distribution";
  let description = [{
    Initializes the Discrete Gaussian Distribution. The distribution is
    initialized with a mean and a standard deviation and pseudo random generator.
  }];

  let arguments = (ins
    PRNG:$input,
    Builtin_IntegerAttr:$mean,
    Builtin_IntegerAttr:$stddev
  );
  let results = (outs Distribution:$output);
  let hasVerifier = 1;
}

def Random_DiscreteUniformDistributionOp : Random_Op<"discrete_uniform_distribution"> {
  let summary = "Initializes the Discrete Uniform Distribution";
  let description = [{
    Initializes the Discrete Uniform Distribution. The distribution is
    initialized with a minimum and a maximum value and pseudo random generator.
    The distribution is inclusive of the minimum and exclusive of the maximum.
  }];

  let arguments = (ins
    PRNG:$input,
    Builtin_IntegerAttr:$min,
    Builtin_IntegerAttr:$max
  );
  let results = (outs Distribution:$output);
  let assemblyFormat = "$input `{` `range` `=` `[` $min `,` $max `]` `}` attr-dict `:` `(` qualified(type($input)) `)` `->` type($output)";
  let hasVerifier = 1;
}

def Random_SampleOp : Random_Op<"sample"> {
  let summary = "Samples from a distribution";
  let description = [{
    Samples from the distribution to obtain a random value.
  }];

  let arguments = (ins
    Distribution:$input
  );
  let results = (outs AnySignlessInteger:$output);
}

def Random_SampleTensorOp : Random_Op<"sample_tensor"> {
  let summary = "Samples a tensor of random values from a distribution";
  let description = [{
    Samples a tensor of random values from the distribution.
  }];

  let arguments = (ins
    Distribution:$input,
    DenseI32ArrayAttr:$shape
  );
  let results = (outs RankedTensorOf<[AnyInteger]>:$output);
  let hasVerifier = 1;
}

#endif  // LIB_DIALECT_RANDOM_IR_RANDOMOPS_TD_
