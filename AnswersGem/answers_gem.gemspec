$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "answers_gem/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "answers_gem"
  s.version     = AnswersGem::VERSION
  s.authors     = ["Alan deLevie"]
  s.email       = ["alan.delevie@gsa.gov"]
  s.homepage    = "https://github.com/18F"
  s.summary     = "The Answers Gem"
  s.description = "The Gem of Answers"
  s.license     = "Public Domain"

  s.files = Dir["{app,config,db,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.4"
  s.add_dependency "sinatra"

  s.add_development_dependency "sqlite3"
end
