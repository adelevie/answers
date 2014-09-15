
# coding: utf-8

require File.expand_path('../core/lib/answers/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = "answers"
  spec.version       = Answers::Version.to_s
  spec.authors       = ["Alan deLevie"]
  spec.email         = ["justin.grevich@gsa.gov", "amos.stone@gsa.gov", "alan.delevie@gsa.gov"]
  spec.summary       = %q{The Answers gem}
  spec.description   = %q{Generator and Engines for the Answers Platform}
  spec.homepage      = ""
  spec.license       = "Public Domain"
  spec.bindir        = 'bin'
  spec.executables   = ['answers']

  spec.files         = `git ls-files -- lib/* templates/*`.split("\n")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "bundler", "~> 1.6"
  spec.add_dependency "rake"
  spec.add_dependency "rails", "~> 4.1.5"
  spec.add_dependency "answers-core"
  spec.add_dependency "rspec-rails", "~> 3.1.0"
  spec.add_dependency 'devise', '~> 3.3.0'
  spec.add_dependency 'pry-nav'
end
