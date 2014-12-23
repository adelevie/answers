ENGINES = %w{ core }

require File.expand_path('../../core/lib/answers/version', __FILE__)
version = Answers::Version.to_s
root = File.expand_path('../../', __FILE__)

(ENGINES + ['answers']).each do |extension|
  namespace extension do
    extension_name = extension
    extension_name = "answers-#{extension}" unless extension == "answers"

    gem_filename = "pkg/#{extension_name}-#{version}.gem"
    gemspec = "#{extension_name}.gemspec"

    task :clean do
      package_dir = "#{root}/pkg"
      mkdir_p package_dir unless File.exists?(package_dir)
      rm_f gem_filename
    end

    task :package do
      cmd = ""
      cmd << "cd #{extension} && " unless extension == "answers"
      cmd << "gem build #{gemspec} && mv #{extension_name}-#{version}.gem #{root}/pkg/"
      sh cmd
    end

    task :build => [:clean, :package]
  end
end

namespace :all do
  task :build => ENGINES.map { |e| "#{e}:build" } + ['answers:build']
end
