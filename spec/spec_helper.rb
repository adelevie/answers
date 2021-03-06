$VERBOSE = ENV['VERBOSE'] || false

require 'rubygems'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), '../') unless defined?(ENGINE_RAILS_ROOT)

Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

# Configure Rails Environment
ENV["RAILS_ENV"] ||= 'test'

require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')
SimpleCov.start('rails')

require File.expand_path("../dummy/config/environment", __FILE__)
require 'database_cleaner'
require 'rspec/rails'
require 'capybara/rspec'
require 'vcr'
require 'webmock/rspec'

Rails.backtrace_cleaner.remove_silencers!

I18n.locale = :en

FactoryGirl.definition_file_paths = %w(core/spec/factories)
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.filter_run :js => true if ENV['JS'] == 'true'
  config.filter_run :js => nil if ENV['JS'] == 'false'
  config.run_all_when_everything_filtered = true
  config.order = "random"
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

  config.include ActionView::TestCase::Behavior, :example_group => { :file_path => %r{spec/presenters} }
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods
  

  config.mock_with(:rspec) { |c| c.syntax = [:expect] }

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

if ENV['CI']
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
else
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[ SimpleCov::Formatter::HTMLFormatter ]
end

VCR.configure do |c|
  c.cassette_library_dir = 'core/spec/fixtures'
  c.hook_into :webmock # or :fakeweb
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
end

WebMock.disable_net_connect!(allow_localhost: true)

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories including factories.
([ENGINE_RAILS_ROOT, Rails.root.to_s].uniq | Answers::Plugins.registered.pathnames).map{|p|
  Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
}.flatten.sort.each do |support_file|
  require support_file
end
