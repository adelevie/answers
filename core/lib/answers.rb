require 'rails' # from railties
require 'active_record'
require 'action_controller'
require 'rbconfig'

module Answers
  require 'answers/errors'

  autoload :Engine, 'answers/engine'
  autoload :CmsGenerator, 'generators/answers/cms/cms_generator'
  autoload :DummyGenerator, 'generators/answers/dummy/dummy_generator'
  autoload :CoreGenerator, 'generators/answers/core/core_generator'
  autoload :EngineGenerator, 'generators/answers/engine/engine_generator'

  class << self
    @@extensions = []

    # Returns an array of modules representing currently registered Answers Engines
    #
    # Example:
    #   Answers.extensions  =>  [Answers::Core, Answers::Pages]
    def extensions
      @@extensions
    end

    # Register an extension with Answers
    #
    # Example:
    #   Answers.register_extension(Answers::Core)
    def register_extension(const)
      return if extension_registered?(const)

      validate_extension!(const)

      @@extensions << const
    end
    alias_method :register_engine, :register_extension

    # Unregister an extension from Answers
    #
    # Example:
    #   Answers.unregister_extension(Answers::Core)
    def unregister_extension(const)
      @@extensions.delete(const)
    end

    # Returns true if an extension is currently registered with Answers
    #
    # Example:
    #   Answers.extension_registered?(Answers::Core)
    def extension_registered?(const)
      @@extensions.include?(const)
    end

    # Constructs a deprecation warning message and warns with Kernel#warn
    #
    # Example:
    #   Answers.deprecate('foo') => "The use of 'foo' is deprecated"
    #
    # An options parameter can be specified to construct a more detailed deprecation message
    #
    # Options:
    #   when - version that this deprecated feature will be removed
    #   replacement - a replacement for what is being deprecated
    #   caller - who called the deprecated feature
    #
    # Example:
    #   Answers.deprecate('foo', :when => 'tomorrow', :replacement => 'bar') =>
    #       "The use of 'foo' is deprecated and will be removed at version 2.0. Please use 'bar' instead."
    def deprecate(what, options = {})
      # Build a warning.
      warning = "\n-- DEPRECATION WARNING --\nThe use of '#{what}' is deprecated"
      warning << " and will be removed at version #{options[:when]}" if options[:when]
      warning << "."
      warning << "\nPlease use #{options[:replacement]} instead." if options[:replacement]

      # See if we can trace where this happened
      if (invoker = detect_invoker(options[:caller])).present?
        warning << invoker
      end

      # Give stern talking to.
      warn warning
    end

    # Returns a Pathname to the root of the Answers project
    def root
      @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
    end

    # Returns an array of Pathnames pointing to the root directory of each extension that
    # has been registered with Answers.
    #
    # Example:
    #   Answers.roots => [#<Pathname:/Users/Reset/Code/answerscms/core>, #<Pathname:/Users/Reset/Code/answerscms/pages>]
    #
    # An optional extension_name parameter can be specified to return just the Pathname for
    # the specified extension. This can be represented in Constant, Symbol, or String form.
    #
    # Example:
    #   Answers.roots(Answers::Core)    =>  #<Pathname:/Users/Reset/Code/answerscms/core>
    #   Answers.roots(:'answers/core')  =>  #<Pathname:/Users/Reset/Code/answerscms/core>
    #   Answers.roots("answers/core")   =>  #<Pathname:/Users/Reset/Code/answerscms/core>
    def roots(extension_name = nil)
      return @roots ||= self.extensions.map(&:root) if extension_name.nil?

      extension_name.to_s.camelize.constantize.root
    end

    def version
      Answers::Version.to_s
    end

    # Returns string version of url helper path. We need this to temporarily support namespaces
    # like Answers::Image and Answers::Blog::Post
    #
    # Example:
    #   Answers.route_for_model(Answers::Image) => "admin_image_path"
    #   Answers.route_for_model(Answers::Image, {:plural => true}) => "admin_images_path"
    #   Answers.route_for_model(Answers::Blog::Post) => "blog_admin_post_path"
    #   Answers.route_for_model(Answers::Blog::Post, {:plural => true}) => "blog_admin_posts_path"
    #   Answers.route_for_model(Answers::Blog::Post, {:admin => false}) => "blog_post_path"
    def route_for_model(klass, options = {})
      options = {:plural => false, :admin => true}.merge options

      klass = klass.constantize if klass.respond_to?(:constantize)
      active_name = ::ActiveModel::Name.new(
        klass, (Answers if klass.parents.include?(Answers))
      )

      if options[:admin]
        # Most of the time this gets rid of 'answers'
        parts = active_name.to_s.underscore.split('/').reject{|name|
          active_name.singular_route_key.exclude?(name)
        }

        # Get the singular resource_name from the url parts
        resource_name = parts.pop
        resource_name = resource_name.pluralize if options[:plural]

        [parts.join("_"), "admin", resource_name, "path"].reject(&:blank?).join "_"
      else
        path = options[:plural] ? active_name.route_key : active_name.singular_route_key

        [path, 'path'].join '_'
      end
    end

    def include_once(base, extension_module)
      base.send :include, extension_module unless included_extension_module?(base, extension_module)
    end

    private
    def detect_invoker(the_caller = caller)
      return '' unless the_caller && the_caller.respond_to?(:detect)
      the_caller.detect{|c| /#{Rails.root}/ === c }.inspect.to_s.split(':in').first
    end

    # plain Module#included? or Module#included_modules doesn't cut it here
    def included_extension_module?(base, extension_module)
      if base.kind_of?(Class)
        direct_superclass = base.superclass
        base.ancestors.take_while {|ancestor| ancestor != direct_superclass}.include?(extension_module)
      else
        base < extension_module # can't do better than that for modules
      end
    end

    def validate_extension!(const)
      unless const.respond_to?(:root) && const.root.is_a?(Pathname)
        raise InvalidEngineError, "Engine must define a root accessor that returns a pathname to its root"
      end
    end
  end
end
