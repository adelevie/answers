class Question < ActiveRecord::Base
  has_many :answers
  searchkick wordnet_synonyms: '/var/lib/wn_s.pl'

  def top_answer
    self.answers.first
  end
end
