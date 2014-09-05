ENV["RAILS_ENV"] ||= 'test'
require 'simplecov'
require 'coveralls'
Coveralls.wear!('rails')
SimpleCov.start('rails')
  
require File.expand_path("../../config/environment", __FILE__)

require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/email/rspec'
require 'database_cleaner'
require 'rspec/collection_matchers'
require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

Capybara.asset_host = 'http://localhost:3000'
Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  #config.extend VCR::RSpec::Macros
  config.include Capybara::DSL
  config.include FactoryGirl::Syntax::Methods

  config.order = 'random'
  
  config.infer_spec_type_from_file_location!
  config.raise_errors_for_deprecations!

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
  c.cassette_library_dir = 'spec/fixtures'
  c.hook_into :webmock # or :fakeweb
  c.default_cassette_options = { record: :new_episodes }
  c.configure_rspec_metadata!
end

WebMock.disable_net_connect!(allow_localhost: true)
