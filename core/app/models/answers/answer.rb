module Answers
	class Answer < ActiveRecord::Base
		self.table_name = 'answers'
	  belongs_to :question
	  searchkick wordnet: true
	end
end