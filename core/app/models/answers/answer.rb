module Answers
	class Answer < ActiveRecord::Base
	  belongs_to :question
	  searchkick wordnet: true
	end
end