require "root_solver/version"

module RootSolver
  class Newton
    def initialize(f, x0 = 0, tol = 0.01, n = 10, eps = 0.001)
      @f   = f
      @x0  = x0
      @tol = tol
      @n   = n
      @eps = eps
    end

    def solve(f = @f, x0 = @x0, tol = @tol, n = @n, eps = @eps)
      y0 = f.call(x0)
      y_prime = (f.call(x0 + eps) - y0) / eps

      raise NonconvergenceError.new if y_prime.abs < tol

      x = x0 - y0 / y_prime
      y = f.call(x)
      if y.abs < tol #successfully found root
        x
      elsif n <= 0 #solver not within threshold after n iterations.
        x
      else
        solve(f, x, tol, n - 1, eps)
      end
    end

  end

  class Bisection
    def initialize(f, low, high, tol = 0.01, n = 10)
      @f    = f
      @tol  = tol
      @n    = n
      @high = high
      @low  = low
    end

    def solve(f = @f, low = @low, high = @high, tol = @tol, n = @n)
      x = (high + low) / 2
      y = f.call(x)

      if y.abs < tol #successfully found root
        x
      elsif n <= 0 #break out of solver after so many iterations
        x
      elsif x_converge?(low, high, tol) && !crossing?(f, low, high)
        raise NoRootError.new
      else #narrow window of searching by half
        if y > 0
          high = x
        else
          low = x
        end
        solve(f, low, high, tol, n - 1)
      end
    end

    private

    #root is between the high and low
    def crossing?(f, low, high)
      f.call(low) * f.call(high)  <= 0
    end

    #high and low are approximately equivalent
    def x_converge?(low, high, tol)
      high - low < tol
    end

  end

  class BisectionNewton
    def initialize(f, low, high, tol = 0.1, n = 5)
      @f    = f
      @tol  = tol
      @n    = n
      @high = high
      @low  = low
    end

    def solve
      x1 = RootSolver::Bisection.new(@f, @low, @high, @tol, @n).solve
      RootSolver::Newton.new(@f, x1, @tol).solve
    end
  end

  class Error < RuntimeError
  end

  class NoRootError < Error
    def initialize(msg = "Root not found.")
      super
    end
  end

  class NonconvergenceError < Error
    def initialize(msg = "Solver not converging.")
      super
    end
  end

end
