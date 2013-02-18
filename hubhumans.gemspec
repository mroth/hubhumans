# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hubhumans/version'

Gem::Specification.new do |gem|
  gem.name          = "hubhumans"
  gem.version       = Hubhumans::VERSION
  gem.authors       = ["Matthew Rothenberg"]
  gem.email         = ["mrothenberg@gmail.com"]
  gem.description   = %q{Automatically create a `humans.txt` file based upon public members of a GitHub organization.}
  gem.summary       = %q{Automatically create a `humans.txt` file based upon public members of a GitHub organization.}
  gem.homepage      = "http://github.com/mroth/hubhumans"
  gem.licenses     = ['MIT']

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "octokit", "~> 1.23.0"
  gem.add_development_dependency "rspec", "~> 2.12.0"
end
