module Answers
  class Question < ActiveRecord::Base

    acts_as_taggable_on :tags
    has_many :answers

    attr_writer :tag_ids
    
    def top_answer
      self.answers.first
    end
    
    # returns tags in order of most taggings to least taggings
    def self.tags
      self.tag_counts_on(:tags).sort_by(&:taggings_count).reverse
    end
    
    def self.tags_with_questions
      tags = self.tag_counts_on(:tags).limit(4).order("taggings_count DESC").all
      tags_with_questions = tags.map do |tag|
        {
          tag: tag,
          questions: Question.find(tag.taggings[0..3].map(&:taggable_id))
        }
      end
      
      tags_with_questions
    end

    # Allow facets for tags
    def search_data
      attributes.merge(
        tag_name: self.tags.map(&:name))
    end

    def to_s
      text
    end
  end
end
