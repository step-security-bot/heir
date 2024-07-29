#ifndef THIRD_PARTY_HEIR_LIB_DIALECT_CKKS_IR_CKKSDIALECT_TD_
#define THIRD_PARTY_HEIR_LIB_DIALECT_CKKS_IR_CKKSDIALECT_TD_

include "mlir/IR/DialectBase.td"
include "mlir/IR/OpBase.td"

def CKKS_Dialect : Dialect {
  // The namespace of the dialect.
  // This corresponds to the string provided in `getDialectNamespace`.
  let name = "ckks";

  let description = [{
    The CKKS dialect defines the types and operations of the CKKS cryptosystem.
  }];

  let cppNamespace = "::mlir::heir::ckks";
}

#endif  // THIRD_PARTY_HEIR_LIB_DIALECT_CKKS_IR_CKKSDIALECT_TD_
