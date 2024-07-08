// RUN: heir-opt %s --split-input-file --verify-diagnostics 2>&1

func.func @test_gaussian_distribution_verifier(%arg0: !random.prng) -> () {
  // expected-error@below {{Expected stddev to be non-negative, found stddev = -1}}
  %0 = random.discrete_gaussian_distribution %arg0 {mean=10, stddev=-1} : (!random.prng) -> !random.distribution
  return
}

// -----

func.func @test_uniform_distribution_verifier(%arg0: !random.prng) -> () {
  // expected-error@below {{Expected min less than max, found min = 1 and max = 0}}
  %1 = random.discrete_uniform_distribution %arg0 {range = [1, 0]} : (!random.prng) -> !random.distribution
  return
}

// -----

func.func @test_sample_tensor_verifier(%arg0: !random.distribution) -> () {
  // expected-error@below {{Expected same input shape attribute as output shape, but found input shape attribute = 10, 5 and output shape = 10}}
  %1 = random.sample_tensor %arg0 {shape = array<i32: 10, 5>} : (!random.distribution) -> tensor<10xi32>
  return
}

// -----

func.func @test_sample_tensor_verifier(%arg0: !random.distribution) -> () {
  // expected-error@below {{Expected same input shape attribute as output shape, but found input shape attribute = 10, 5 and output shape = 10, 10}}
  %1 = random.sample_tensor %arg0 {shape = array<i32: 10, 5>} : (!random.distribution) -> tensor<10x10xi32>
  return
}
