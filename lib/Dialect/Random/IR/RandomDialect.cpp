#include "lib/Dialect/Random/IR/RandomDialect.h"

#include <cassert>

#include "llvm/include/llvm/ADT/TypeSwitch.h"            // from @llvm-project
#include "llvm/include/llvm/Support/LogicalResult.h"     // from @llvm-project
#include "mlir/include/mlir/IR/BuiltinTypes.h"           // from @llvm-project
#include "mlir/include/mlir/IR/DialectImplementation.h"  // from @llvm-project
#include "mlir/include/mlir/IR/TypeUtilities.h"          // from @llvm-project
#include "mlir/include/mlir/Support/LLVM.h"              // from @llvm-project
#include "mlir/include/mlir/Support/LogicalResult.h"     // from @llvm-project

// NOLINTBEGIN(misc-include-cleaner): Required to define RandomDialect and
// RandomOps
#include "lib/Dialect/Random/IR/RandomOps.h"
#include "lib/Dialect/Random/IR/RandomTypes.h"
// NOLINTEND(misc-include-cleaner)

// Generated definitions
#include "lib/Dialect/Random/IR/RandomDialect.cpp.inc"

#define GET_TYPEDEF_CLASSES
#include "lib/Dialect/Random/IR/RandomTypes.cpp.inc"
#define GET_OP_CLASSES
#include "lib/Dialect/Random/IR/RandomOps.cpp.inc"

namespace mlir {
namespace heir {
namespace random {

void RandomDialect::initialize() {
  addOperations<
#define GET_OP_LIST
#include "lib/Dialect/Random/IR/RandomOps.cpp.inc"
      >();
  addTypes<
#define GET_TYPEDEF_LIST
#include "lib/Dialect/Random/IR/RandomTypes.cpp.inc"
      >();
}

LogicalResult DiscreteGaussianDistributionOp::verify() {
  if (getStddev().getInt() < 0) {
    return emitOpError()
           << "Expected stddev to be non-negative, found stddev = "
           << getStddev().getInt();
  }
  return success();
}

LogicalResult DiscreteUniformDistributionOp::verify() {
  if (getMin().getInt() >= getMax().getInt()) {
    return emitOpError() << "Expected min less than max, found min = "
                         << getMin().getInt()
                         << " and max = " << getMax().getInt();
  }
  return success();
}

LogicalResult SampleTensorOp::verify() {
  auto shape = getShape();
  auto outputShape = getOutput().getType().getShape();
  if (shape.size() != outputShape.size()) {
    return emitOpError() << "Expected same input shape attribute as output "
                            "shape, but found input shape attribute = "
                         << shape << " and output shape = " << outputShape;
  }

  for (int i = 0; i < shape.size(); ++i) {
    if (shape[i] != outputShape[i]) {
      return emitOpError() << "Expected same input shape attribute as output "
                              "shape, but found input shape attribute = "
                           << shape << " and output shape = " << outputShape;
    }
  }
  return success();
}

}  // namespace random
}  // namespace heir
}  // namespace mlir
