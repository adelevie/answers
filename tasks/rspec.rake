require 'rspec/core/rake_task'

desc "Run specs"
RSpec::Core::RakeTask.new do |t|
  t.pattern = "./*/spec"
end

task :spec => "answers:testing:dummy_app"
