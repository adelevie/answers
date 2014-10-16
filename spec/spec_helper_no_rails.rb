ENV['RAILS_ENV'] ||= 'TEST'
require 'active_support'
EXTENSIONS = %w[core]
Dir[File.expand_path("../{#{EXTENSIONS.join(',')}}/app/models", __FILE__)].each do |model_dir|
  $:.push File.expand_path('../../app/models/', __FILE__)
end
