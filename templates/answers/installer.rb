require 'rbconfig'
VERSION_BAND = '0.0'
MINOR_VERSION_BAND = '0.0.5'

# We want to ensure that you have an ExecJS runtime available!
begin
  require 'execjs'
rescue LoadError
  abort "ExecJS is not installed. Please re-start the installer after running:\ngem install execjs"
end

if File.read("#{destination_root}/Gemfile") !~ /assets.+coffee-rails/m
  gem "coffee-rails", :group => :assets
end

append_file 'Gemfile', <<-GEMFILE

# Answers
gem 'answers', path: '../'
gem 'searchkick'
gem 'acts-as-taggable-on'
gem 'dalli'
gem 'devise', '~> 3.2.4'
gem "breadcrumbs_on_rails"
gem 'activeadmin', github: 'gregbell/active_admin' 
gem 'secure_headers'


#  gem 'answers-admin', ['~> #{VERSION_BAND}', '>= #{MINOR_VERSION_BAND}']
#  gem 'answers-guides', ['~> #{VERSION_BAND}', '>= #{MINOR_VERSION_BAND}']
#  gem 'answers-choose-your-own-adventure', ['~> #{VERSION_BAND}', '>= #{MINOR_VERSION_BAND}']
GEMFILE

begin
  require 'execjs'
  ::ExecJS::Runtimes.autodetect
rescue
  gsub_file 'Gemfile', "# gem 'therubyracer'", "gem 'therubyracer'"
end

run 'bundle install'
rake 'db:create'

generate "answers:cms --fresh-installation #{ARGV.join(' ')}"

say <<-SAY
  ============================================================================
    Your new Answers application is now installed and mounts at '/'
  ============================================================================
SAY