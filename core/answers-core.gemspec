# Encoding: UTF-8
require File.expand_path('../../core/lib/answers/version', __FILE__)

version = '0.0.0.2' #Answers::Version.to_s
rails_version = '~> 4.1.6'

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{answers-core}
  s.version           = version
  s.summary           = %q{Core extension for Answers Platlform}
  s.description       = %q{The core of Answers Platform. This handles the common functionality and is required by most extensions}
  s.email             = ["justin.grevich@gsa.gov", "amos.stone@gsa.gov", "alan.delevie@gsa.gov"]
  s.homepage          = %q{http://answers.domain.com}
  s.authors           = ['Nick Bristow', 'Alan deLevie', 'Justin Grevich', 'Sasha Magee', 'Amos Stone', 'Ben Willman', 'John P. Yuda']
  s.license           = "Public Domain"
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- spec/*`.split("\n")

  s.required_ruby_version = '>= 2.1.2'

  s.add_dependency 'rails',                       rails_version
  s.add_dependency 'railties',                    rails_version
  s.add_dependency 'activerecord',                rails_version
  s.add_dependency 'actionpack',                  rails_version
  s.add_dependency 'devise',                      '~>3.2.0'
end
