class Answer < ActiveRecord::Base
  belongs_to :question
  searchkick wordnet: true
  
  def display_text
    result = text ? text.gsub(/(\[[0-9+]\]:)/, "\n\n" + '\1') : ""
  end
end