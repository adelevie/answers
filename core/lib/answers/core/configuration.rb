module Answers
  module Core
    include ActiveSupport::Configurable

    config_accessor :rescue_not_found, :s3_backend, :base_cache_key, :site_name,
                    :google_analytics_page_code, :authenticity_token_on_frontend,
                    :dragonfly_secret, :javascripts, :stylesheets,
                    :s3_bucket_name, :s3_region, :s3_access_key_id,
                    :s3_secret_access_key, :force_ssl, :backend_route,
                    :dragonfly_custom_backend_class, :dragonfly_custom_backend_opts,
                    :visual_editor_javascripts, :visual_editor_stylesheets

    self.rescue_not_found = false
    self.s3_backend = false
    self.base_cache_key = :answers
    self.site_name = "Company Name"
    self.google_analytics_page_code = "UA-xxxxxx-x"
    self.authenticity_token_on_frontend = false
    self.dragonfly_secret = Array.new(24) { rand(256) }.pack('C*').unpack('H*').first
    self.javascripts = []
    self.stylesheets = []
    self.s3_bucket_name = ENV['S3_BUCKET']
    self.s3_region = ENV['S3_REGION']
    self.s3_access_key_id = ENV['S3_KEY']
    self.s3_secret_access_key = ENV['S3_SECRET']
    self.force_ssl = false
    self.backend_route = "answers"
    self.dragonfly_custom_backend_class = ''
    self.dragonfly_custom_backend_opts = {}
    self.visual_editor_javascripts = []
    self.visual_editor_stylesheets = []

    def config.register_javascript(name)
      self.javascripts << name
    end

    def config.register_stylesheet(*args)
      self.stylesheets << Stylesheet.new(*args)
    end

    def config.register_visual_editor_javascript(name)
      self.visual_editor_javascripts << name
    end

    def config.register_visual_editor_stylesheet(*args)
      self.visual_editor_stylesheets << Stylesheet.new(*args)
    end

    class << self
      def backend_route
        # prevent / at the start.
        config.backend_route.to_s.gsub(%r{\A/}, '')
      end

      def clear_javascripts!
        self.javascripts = []
      end

      def clear_stylesheets!
        self.stylesheets = []
      end

      def dragonfly_custom_backend?
        config.dragonfly_custom_backend_class.present?
      end

      def dragonfly_custom_backend_class
        config.dragonfly_custom_backend_class.constantize if dragonfly_custom_backend?
      end

      def site_name
        ::I18n.t('site_name', :scope => 'answers.core.config', :default => config.site_name)
      end

      def wymeditor_whitelist_tags=(tags)
        raise "Please ensure answers-wymeditor is being used and use Answers::Wymeditor.whitelist_tags instead of Answers::Core.wymeditor_whitelist_tags"
      end
    end

    # wrapper for stylesheet registration
    class Stylesheet
      attr_reader :options, :path
      def initialize(*args)
        @options = args.extract_options!
        @path = args.first if args.first
      end
    end

  end
end
