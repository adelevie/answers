# Encoding: UTF-8
require File.expand_path('../../core/lib/answers/version', __FILE__)

version = Answers::Version.to_s

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = %q{answers-testing}
  s.version           = version
  s.summary           = %q{Testing plugin for Answers}
  s.description       = %q{This plugin adds the ability to test against the Answers CMS gem while inside an Answers extension}
  s.email             = %q{justin.grevich@gsa.gov}
  s.homepage          = %q{https://answers.18f.us}
  s.rubyforge_project = %q{answers}
  s.authors           = ['Nick Bristow', 'Alan deLevie', 'Justin Grevich', 'Sasha Magee', 'John Stone', 'Ben Willman', 'John P. Yuda']
  s.license           = %q{CC0}
  s.require_paths     = %w(lib)

  s.files             = `git ls-files`.split("\n")

  s.add_dependency 'answers-core'
  s.add_dependency 'database_cleaner',        '~> 1.2.0'
  s.add_dependency 'factory_girl_rails',      '~> 4.2.1'
  s.add_dependency 'rspec-rails',             '~> 3.1.0'
  s.add_dependency 'capybara',                '~> 2.1.0'
  s.add_dependency 'capybara-webkit',         '~> 1.3.0'
  s.add_dependency 'devise',                      '~> 3.3.0'

end
