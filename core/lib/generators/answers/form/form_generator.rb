require 'answers/extension_generation'
require 'rails/generators/migration'

module Answers
  class FormGenerator < Rails::Generators::NamedBase
    source_root Pathname.new(File.expand_path('../templates', __FILE__))

    include Answers::ExtensionGeneration

    def description
      "Generates an extension which is set up for frontend form submissions like a contact page."
    end

    def generate
      default_generate!
    end

    protected

    def generator_command
      'rails generate answers:form'
    end

  end
end
