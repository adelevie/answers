module AnswersGem

  class Wordcount < ActiveRecord::Base
    belongs_to :article
    #  TODO: set this via metaprogramming for whatever the AR model is called that has keywords.
    belongs_to :keyword

    before_validation :set_count_if_nil

    private

    def set_count_if_nil
      self.count = 0 if self.count.nil?
    end

  end

end
