source 'https://rubygems.org'

# Specify your gem's dependencies in answers.gemspec
gemspec

gem 'activeadmin', github: 'activeadmin'
gem 'acts-as-taggable-on'
gem 'breadcrumbs_on_rails'
gem 'cancancan', github: 'andypike/cancancan', branch: 'rspec3'
gem 'quiet_assets'
gem 'reverse_markdown'
gem 'secure_headers'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'searchkick'

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

group :test do
  gem 'answers-testing'
  gem 'answers-core'
  gem 'brakeman', require: false
  gem 'coveralls', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'generator_spec', '~> 0.9.1'
  gem 'launchy'
  gem 'meta-tags'
  gem 'pry-nav'
  gem 'sqlite3'
  gem 'turbolinks'
end
