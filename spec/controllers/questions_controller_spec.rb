require 'spec_helper'

RSpec.describe ::QuestionsController, type: :feature do
  let(:question)  { create(:question) }
  let(:questions) { [question] }
  let(:tag)       { create(:tag) }
  
  describe "GET show" do
    it "should show a Question with its tags" do      
      allow(Question).to(receive(:find).with(question.id.to_s)).and_return(question)
      allow(question).to(receive(:tags)).and_return([tag])
      
      visit answer_path(question.id)
      
      expect(page).to(have_content(question.text))
      expect(page).to(have_content(tag.name.capitalize))            
    end
  end

  describe "GET index" do
    it "should show a list of Questions" do
      allow(Question).to(receive(:all)).and_return(questions)
      
      visit answers_path
      
      expect(page).to(have_content("All Answers"))
      expect(page).to(have_content(question.text))      
    end
  end

end
