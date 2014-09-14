module Answers
  module Core
    class Engine < ::Rails::Engine
      extend Answers::Engine

      isolate_namespace Answers
      engine_name :answers

      class << self
        # Register all decorators from app/decorators/ and registered plugins' paths.
        def register_decorators!
          #Decorators.register! Rails.root, Answers::Plugins.registered.pathnames
        end

        # Performs the Answers inclusion process which extends the currently loaded Rails
        # applications with Answers's controllers and helpers. The process is wrapped by
        # a before_inclusion and after_inclusion step that calls procs registered by the
        # Answers::Engine#before_inclusion and Answers::Engine#after_inclusion class methods
        def answers_inclusion!
          before_inclusion_procs.each(&:call)

          #Answers.include_once(::ApplicationController, Answers::ApplicationController)
          #::ApplicationController.send :helper, Answers::Core::Engine.helpers

          after_inclusion_procs.each(&:call)
        end
      end

      require 'devise'
      config.to_prepare do
        Devise::SessionsController.layout "answers/application"
      end

      config.autoload_paths += %W( #{config.root}/lib )

      # Include the answers controllers and helpers dynamically
      config.to_prepare &method(:answers_inclusion!).to_proc

      after_inclusion &method(:register_decorators!).to_proc

      # Wrap errors in spans
      config.to_prepare do
        ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
          "<span class=\"fieldWithErrors\">#{html_tag}</span>".html_safe
        end
      end

      initializer "register answers_core plugin" do
        Answers::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'answers_core'
          plugin.class_name = 'AnswersEngine'
          plugin.hide_from_menu = true
          plugin.always_allow_access = true
          plugin.menu_match = /answers\/(answers_)?core$/
        end
      end

      initializer "register answers_dialogs plugin" do
        Answers::Plugin.register do |plugin|
          plugin.pathname = root
          plugin.name = 'answers_dialogs'
          plugin.hide_from_menu = true
          plugin.always_allow_access = true
          plugin.menu_match = /answers\/(answers_)?dialogs/
        end
      end

      initializer "answers.routes", :after => :set_routes_reloader_hook do |app|
        Answers::Core::Engine.routes.append do
          get "#{Answers::Core.backend_route}/*path" => 'admin#error_404'
        end
      end

      initializer "answers.autoload_paths" do |app|
        app.config.autoload_paths += [
          Rails.root.join('app', 'presenters'),
          Rails.root.join('vendor', '**', '**', 'app', 'presenters'),
          Answers.roots.map{|r| r.join('**', 'app', 'presenters')}
        ].flatten
      end

      # set the manifests and assets to be precompiled
      config.to_prepare do
        Rails.application.config.assets.precompile += %w(
          answers/*
          answers/icons/*
          modernizr-min.js
          admin.js
        )
      end

      # active model fields which may contain sensitive data to filter
      initializer "answers.params.filter" do |app|
        app.config.filter_parameters += [:password, :password_confirmation]
      end

      initializer "answers.encoding" do |app|
        app.config.encoding = 'utf-8'
      end

      initializer "answers.memory_store" do |app|
        app.config.cache_store = :memory_store
      end

      config.after_initialize do
        Answers.register_extension(Answers::Core)
      end
    end
  end
end
