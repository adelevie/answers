module Answers
	class Answer < ActiveRecord::Base
	  belongs_to :question
	  searchkick wordnet: true

	  def to_s
			text
		end
	end
end