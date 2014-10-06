require 'spec_helper'

RSpec.describe "answers/questions/show", :type => :view do
  it "renders attributes in <p>" do
    # create a mocked question
    question_text = "Question Text"
    question = create(:question, text: question_text)
    
    # mock the similar method
    allow_any_instance_of(Answers::Question).to receive(:similar).and_return([question, question, question])
    similar_questions = question.similar
    
    # load the locals hash and render the template
    locals = {
      question: question,
      similar_questions: similar_questions
    }
    render template: 'answers/questions/show', locals: locals
    
    expect(rendered).to(have_content(question_text))
  end
end
