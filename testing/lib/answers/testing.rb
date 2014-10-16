require 'answers-core'
require 'devise'
require 'rspec-rails'
require 'factory_girl_rails'

module Answers
  autoload :TestingGenerator, 'generators/answers/testing/testing_generator'

  module Testing
    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      # Load the factories of all currently loaded extensions
      def load_factories
        Answers.extensions.each do |extension_const|
          if extension_const.respond_to?(:factory_paths)
            extension_const.send(:factory_paths).each do |path|
              FactoryGirl.definition_file_paths << path
            end
          end
        end
        FactoryGirl.find_definitions
      end
    end

    require 'answers/testing/railtie'

    autoload :ControllerMacros, 'answers/testing/controller_macros'
    autoload :FeatureMacros, 'answers/testing/feature_macros'
  end
end
