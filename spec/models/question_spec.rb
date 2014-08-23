require 'spec_helper'

RSpec.describe Question, :type => :model do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  context "when an accepted answer exists" do
    it "should return the top answer" do
      question.answers << answer

      question.save

      expect(question.top_answer).to be_valid
    end
  end

  context "top_answer" do
    let(:question) { create(:question) }

    it "should return nil" do
      expect(question.top_answer).to be_nil
    end
  end
end
