class Answer < ActiveRecord::Base
  belongs_to :question
  searchkick
end
