# RootSolver

[root_solver](https://github.com/teamairship/root_solver) will solve for a
root of a mathematical function using a bisection method to get close then
switching over to Newton's method to hone in.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'root_solver'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install root_solver

## Usage

[root_solver](https://github.com/teamairship/root_solver) expects a callable
(proc, lambda, PORO responding to call). The callable should take one argument,
our `x`, and the callable should evaluate our function at x. Example callable:

```ruby
f    = Proc.new { |x| x ** 2 - 10 } # Function for which we wish to find roots
low  = -5															# An educated guess for the lower limit
high = 5															# An educated guess for the upper limit
tol  = 1e-3														# How accurate do we want to be

RootSolver::BisectionNewton.new(f, low, 0, tol).solve
=> -3.1622776375625614
RootSolver::BisectionNewton.new(f, 0, high, tol).solve
=> 3.1622813514478687

# If there are multiple roots between low and high, root_solver will find one
RootSolver::BisectionNewton.new(f, low, high, tol).solve
=> 3.1622813514478687
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/teamairship/root_solver.

