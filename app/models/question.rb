class Question < ActiveRecord::Base
  has_many :answers
  searchkick
end
