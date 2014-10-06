source 'https://rubygems.org'

# Specify your gem's dependencies in answers.gemspec
gemspec

gem 'actionpack-page_caching'
gem 'activeadmin', github: 'activeadmin'
gem 'acts-as-taggable-on'
gem 'breadcrumbs_on_rails'
gem 'cancancan', github: 'andypike/cancancan', branch: 'rspec3'
gem 'meta-tags'
gem 'reverse_markdown'
gem 'secure_headers'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'searchkick'
gem 'turbolinks'
gem 'friendly_id',                 '~> 5.0.0'

# Database Configuration
unless ENV['TRAVIS']
  gem 'activerecord-jdbcsqlite3-adapter', '>= 1.3.0.rc1', platform: :jruby
  gem 'sqlite3', platform: :ruby
end

if !ENV['TRAVIS'] || ENV['DB'] == 'mysql'
  group :mysql do
    gem 'activerecord-jdbcmysql-adapter', '>= 1.3.0.rc1', platform: :jruby
    gem 'mysql2', platform: :ruby
  end
end

if !ENV['TRAVIS'] || ENV['DB'] == 'postgresql'
  group :postgres, :postgresql do
    gem 'activerecord-jgbdbcpostgresql-adapter', '>= 1.3.0.rc1', platform: :jruby
    gem 'pg', platform: :ruby
  end
end


group :development do
  gem 'better_errors'
  gem 'berkshelf'
  gem 'binding_of_caller'
  gem 'capistrano'
  gem 'guard-rspec', require: false
  gem 'knife-ec2'
  gem 'knife-solo', github: 'matschaffer/knife-solo', submodules: true
  gem 'knife-solo_data_bag'
  gem 'quiet_assets'
  gem 'rb-fsevent'
  gem 'rvm-capistrano'
  gem 'spring-commands-rspec'
  gem 'unf'
end

group :development, :test do
  gem 'brakeman', require: false
  gem 'coveralls', require: false
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'inch', require: false
  gem 'memcached'
  gem 'pry-nav'
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
end

group :test do
  gem 'answers-testing'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'generator_spec', '~> 0.9.1'
  gem 'launchy'
  gem 'webmock'
  gem 'vcr'
end
