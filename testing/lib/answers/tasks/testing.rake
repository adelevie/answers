namespace :answers do
  namespace :testing do
    desc "Generates a dummy app for testing"
    task :dummy_app do
      unless dummy_app_path.exist?
        Rake::Task["answers:testing:setup_dummy_app"].invoke
        Rake::Task["answers:testing:setup_extension"].invoke
        Rake::Task["answers:testing:init_test_database"].invoke
      end
    end

    task :setup_dummy_app do
      require 'answers-core'

      params = %w(--quiet)
      params << "--database=#{ENV['DB']}" if ENV['DB']

      Answers::DummyGenerator.start params

      # Ensure the database is not there from a previous run.
      Rake::Task['answers:testing:drop_dummy_app_database'].invoke

      Answers::CmsGenerator.start %w[--quiet --fresh-installation]

      Dir.chdir dummy_app_path
    end

    # This task is a hook to allow extensions to pass configuration
    # Just define this inside your extension's Rakefile or a .rake file
    # and pass arbitrary code. Example:
    #
    # namespace :answers do
    #   namespace :testing do
    #     task :setup_extension do
    #       require 'answers-my-extension'
    #       Answers::MyEngineGenerator.start %w[--quiet]
    #     end
    #   end
    # end
    task :setup_extension do
    end

    desc "Remove the dummy app used for testing"
    task :clean_dummy_app do
      Rake::Task['answers:testing:drop_dummy_app_database'].invoke
      dummy_app_path.rmtree if dummy_app_path.exist?
    end

    desc "Remove the dummy app's database."
    task :drop_dummy_app_database do
      system "bundle exec rake -f #{File.join(dummy_app_path, 'Rakefile')} db:drop"
    end

    task :init_test_database do
      system "RAILS_ENV=test bundle exec rake -f #{File.join(dummy_app_path, 'Rakefile')} db:{create,migrate}"
    end

    task :specs do
      paths = Dir.glob('vendor/extensions/*/spec')
      paths << Rails.root

      status = 0
      paths.each do |path|
        if Rails.root.join(path).basename.to_s == 'spec'
          path = Rails.root.join(path).parent
        end
        cmd = "running specs in #{ path.basename }"
        puts "\n#{ "-" * cmd.to_s.length }\n#{ cmd }\n#{"-" * cmd.to_s.length }"
        Dir.chdir(path) do
          IO.popen("bundle exec bundle install && bundle exec rake answers:testing:dummy_app") unless path == Rails.root
          IO.popen("bundle exec rake spec") do |f|
            f.each { |line| puts line }
            f.close
            status = 1 if $?.to_i > 0
          end
        end
      end
      abort "Some tests failed" if status > 0
    end

    def dummy_app_path
      Answers::Testing::Railtie.target_extension_path.join('spec', 'dummy')
    end
  end
end
