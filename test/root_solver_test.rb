require 'test_helper'

class RootSolverTest < Minitest::Test
  def setup
    @bisection_newton = RootSolver::BisectionNewton
    @bisection = RootSolver::Bisection
  end

  def test_that_it_has_a_version_number
    refute_nil ::RootSolver::VERSION
  end

  def test_finds_root_with_root_as_initial_guess
    assert_in_delta 0, @bisection_newton.new(one_rooted_function, 0, 10, 1e-3).solve, 1e-3
    assert_in_delta 0, @bisection.new(one_rooted_function, 0, 10, 1e-3).solve, 1e-3
  end

  def test_finds_root_of_one_rooted_function
    assert_in_delta 0, @bisection_newton.new(one_rooted_function, -10, 10, 1e-3).solve, 1e-3
    assert_in_delta 0, @bisection.new(one_rooted_function, -10, 10, 1e-3).solve, 1e-3
  end

  def test_finds_root_of_two_rooted_function
    bn_solution = @bisection_newton.new(two_rooted_function, 0, 10, 1e-3).solve
    b_solution = @bisection.new(two_rooted_function, 0, 10, 1e-3).solve

    assert_in_delta 0, two_rooted_function.call(bn_solution), 1e-3
    assert_in_delta 0, two_rooted_function.call(b_solution), 1e-3
  end

  def test_raises_for_non_crossing_high_low
    assert_raises RootSolver::NonCrossingError do
      @bisection_newton.new(two_rooted_function, 10, 10, 1e-3).solve
    end

    assert_raises RootSolver::NonCrossingError do
      @bisection.new(two_rooted_function, 10, 10, 1e-3).solve
    end
  end

  def test_raises_for_a_non_rooted_function
    assert_raises RootSolver::NonCrossingError do
      3.times { puts @bisection_newton.new(non_rooted_function, -100, 100, 1e-3, 50).solve }
    end

    assert_raises RootSolver::NonCrossingError do
      3.times { puts @bisection.new(non_rooted_function, -100, 100, 1e-3, 50).solve }
    end
  end

  private
    def one_rooted_function
      Proc.new { |x| x ** 2 }
    end

    def two_rooted_function
      Proc.new { |x| -1 + x ** 2 }
    end

    def non_rooted_function
      Proc.new { |x| 10 + (x ** 2) }
    end
end

