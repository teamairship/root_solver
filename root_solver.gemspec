# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'root_solver/version'

Gem::Specification.new do |spec|
  spec.name          = "root_solver"
  spec.version       = RootSolver::VERSION
  spec.authors       = ["Lindsay Hannon"]
  spec.email         = ["lindsay@teamairship.com"]

  spec.summary       = %q{ A root-solver that uses bisection then newton's method to approximate a function's root }
  spec.description   = %q{ Newton's method works best when you have a reasonable first guess, while bisection is a
                           better choice when your first guess may be far away (or near a zero slope). }
  spec.homepage      = "https://github.com/teamairship/root_solver"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
