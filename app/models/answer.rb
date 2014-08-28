class Answer < ActiveRecord::Base
  belongs_to :question
  searchkick wordnet_synonyms: '/var/lib/wn_s.pl'
end