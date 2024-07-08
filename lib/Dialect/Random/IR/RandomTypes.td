#ifndef HEIR_LIB_DIALECT_RANDOM_IR_RANDOMTYPES_TD_
#define HEIR_LIB_DIALECT_RANDOM_IR_RANDOMTYPES_TD_

include "RandomDialect.td"

include "mlir/IR/DialectBase.td"
include "mlir/IR/AttrTypeBase.td"

// A base class for all types in this dialect
class Random_Type<string name, string typeMnemonic>
    : TypeDef<Random_Dialect, name> {
  let mnemonic = typeMnemonic;
}

def Distribution : Random_Type<"Distribution", "distribution"> {
  let summary = "A random distribution";

  let description = [{
    A generic type, representing a random distribution but not specifying the
    distribution type (i.e. uniform, gaussian, etc.).
  }];
}

def PRNG : Random_Type<"PRNG", "prng"> {
  let summary = "A psuedorandom number generator";

  let description = [{
    A type that provides pseudorandom number generator.
  }];
}

#endif  // HEIR_LIB_DIALECT_RANDOM_IR_RANDOMTYPES_TD_
