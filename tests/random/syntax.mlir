// This test only checks that the syntax is correct.

// RUN: heir-opt %s

func.func @test_random(%arg0: i32) -> () {
  %0 = random.init_prng %arg0 : (i32) -> !random.prng
  %1 = random.discrete_gaussian_distribution %0 {mean=10, stddev=10} : (!random.prng) -> !random.distribution
  %2 = random.sample %1 : (!random.distribution) -> i32
  %3 = random.sample_tensor %1 {shape = array<i32: 10>} : (!random.distribution) -> tensor<10xi32>

  %4 = random.init_prng %arg0 : (i32) -> !random.prng
  %5 = random.discrete_uniform_distribution %4 {range = [-1, 2]} : (!random.prng) -> !random.distribution
  %6 = random.sample %5 : (!random.distribution) -> i32
  %7 = random.sample_tensor %5 {shape = array<i32: 10>} : (!random.distribution) -> tensor<10xi32>
  return
}
