require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'csv'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Answers
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W( #{config.root}/lib #{config.root}/lib/rails_nlp )
    config.autoload_paths += %W( #{config.root}/controllers/api )
    config.autoload_paths += %W( #{config.root}/models/api )
    config.autoload_paths += %W( #{config.root}/views/api )

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.i18n.enforce_available_locales = true
    # or if one of your gem compete for pre-loading, use
    I18n.config.enforce_available_locales = true

    # Enable tables in the content fields for Articles
    config.action_view.sanitized_allowed_tags = 'table', 'tr', 'td'
  end
end
