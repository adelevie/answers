source 'https://rubygems.org'

gem 'pry'
#gem 'pry', git: "https://github.com/adelevie/pry.git"

gem 'nokogiri', '> 1.4.7'
gem 'rails', '4.1.4'
gem 'pg'
gem 'thin'
gem 'foreman'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
gem 'actionpack-page_caching'

gem 'searchkick', github: 'amoose/searchkick', branch: 'feature/es_syn_tokenization'


gem 'acts-as-taggable-on'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'newrelic_rpm', group: [:production, :staging, :development]
gem 'annotate'
gem 'progressbar'
gem 'facets', require: false

gem 'meta-tags', require: 'meta_tags'

gem 'delayed_job_active_record'
gem 'memcachier'
gem 'dalli'
gem 'kgio'

gem 'devise', '~> 3.2.4'
gem 'cancancan', github: 'andypike/cancancan', branch: 'rspec3'

gem 'text'
gem 'httparty'
gem 'json'

gem 'bluecloth'
gem 'kramdown'
gem 'reverse_markdown'
gem 'friendly_id', '~> 5.0.4'
gem 'gon'
gem 'paperclip', '~> 4.1.1'
gem 'aws-sdk', '~> 1.42.0'
gem 'dotenv-rails'
gem "breadcrumbs_on_rails"
gem 'therubyracer'
gem 'activeadmin', github: 'gregbell/active_admin' 
gem 'secure_headers'

gem 'simple_token_authentication'
gem 'style_guide', :git => 'git@github.com:18F/myuscis-style-guide.git'

group :development do
  gem 'better_errors'
  gem 'berkshelf'
  gem 'binding_of_caller'
  gem 'capistrano', '~> 2.15'
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
  gem 'rspec-collection_matchers'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara', '~> 2.3.0'
  gem 'capybara-screenshot'
  gem 'capybara-webkit'
  gem 'capybara-email'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'rspec-html-matchers'
  gem 'shoulda'
  gem 'webmock'
  gem 'vcr'
end
