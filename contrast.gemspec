# -*- encoding: utf-8 -*-
require File.expand_path('../lib/contrast/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darren Cauthon"]
  gem.email         = ["darren@cauthon.com"]
  gem.description   = %q{Contrast two objects by a defined set of values}
  gem.summary       = %q{Contrast two objects by a defined set of values}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "contrast"
  gem.require_paths = ["lib"]
  gem.version       = Contrast::VERSION

  gem.add_runtime_dependency 'subtle'
  gem.add_runtime_dependency 'awesome_print'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'rake'
end
