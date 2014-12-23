module Answers
  class CoreGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
		
    def generate_answers_initializer
      template "config/initializers/answers/core.rb.erb",
         File.join(destination_root, "config", "initializers", "answers", "core.rb")
    end
  end
end
