require 'spec_helper'

RSpec.describe Answers::Answer, :type => :model do
  it "belongs_to Answers::Question" do
    question_id = 1
    create(:question, id: question_id)
    
    answer = Answers::Answer.new
    answer.question_id = question_id
    text = "Answer text"
    answer.text = text
    answer.save
    
    expect(answer.question).to(be_a(Answers::Question))
  end
  
  it "has searchkick enabled" do
    expect(Answers::Answer).to(respond_to(:reindex))
  end
end
