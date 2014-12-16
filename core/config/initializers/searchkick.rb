
# Allow other applications to define searchkick options for their models.
# Check Searchkick instantiation the same way that their gem does
# https://github.com/ankane/searchkick/blob/master/lib/searchkick/model.rb#L7

class Application < Rails::Railtie
  config.after_initialize do
    options = { wordnet: true }
    next if Answers::Question.respond_to?(:searchkick_index) ||
            Answers::Question.subclasses.any? { |x| x.respond_to?(:searchkick_index) }
    Answers::Question.send(:searchkick, options)

    next if Answers::Answer.respond_to?(:searchkick_index) ||
            Answers::Answer.subclasses.any? { |x| x.respond_to?(:searchkick_index) }
    Answers::Answer.send(:searchkick, options)
  end
end