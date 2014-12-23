require File.expand_path('../../answers', __FILE__)
#require 'truncate_html'
#require 'will_paginate'
#surrequire 'answers/i18n'

module Answers
  module Core
    require 'answers/core/engine'
    require 'answers/core/configuration'

    class << self
      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end
    end
  end
end

# this require has to be down here
# see https://github.com/refinery/refinerycms/issues/2273
#require 'decorators'
#require 'jquery-rails'
#require 'jquery-ui-rails'
#require 'sass-rails'
#require 'coffee-rails'
