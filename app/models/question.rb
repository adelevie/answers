class Question < ActiveRecord::Base
  has_many :answers
  searchkick


  def top_answer
    self.answers.first
  end
end
