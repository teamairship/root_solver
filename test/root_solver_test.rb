require 'test_helper'

class RootSolverTest < Minitest::Test
  def setup
    @subject = RootSolver::BisectionNewton
  end

  def test_that_it_has_a_version_number
    refute_nil ::RootSolver::VERSION
  end

  def test_finds_root_of_one_rooted_function
    assert_in_delta 0, @subject.new(one_rooted_function, -10, 10, 1e-3).solve, 1e-3
  end

  def test_finds_root_of_two_rooted_function
    solution = @subject.new(two_rooted_function, -10, 10, 1e-3).solve

    assert_in_delta 0, two_rooted_function.call(solution), 1e-3
  end

  def test_raises_for_a_non_rooted_function
    assert_raises RootSolver::NoRootError do
      3.times { puts @subject.new(non_rooted_function, -100, 100, 1e-3, 50).solve }
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
