# Encoding: UTF-8
require File.expand_path('../../core/lib/answers/version', __FILE__)

version = Answers::Version.to_s
rails_version = '~> 4.1.4'

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{answers-core}
  s.version           = version
  s.summary           = %q{Core extension for Answers Platlform}
  s.description       = %q{The core of Answers Platform. This handles the common functionality and is required by most extensions}
  s.email             = %q{info@domain.com}
  s.homepage          = %q{http://answers.domain.com}
  s.authors           = ["Alan deLevie"]
  s.license           = "Public Domain"
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.required_ruby_version = '>= 2.1.2'

  s.add_dependency 'rails',                       rails_version
  s.add_dependency 'railties',                    rails_version
  s.add_dependency 'activerecord',                rails_version
  s.add_dependency 'actionpack',                  rails_version
end
