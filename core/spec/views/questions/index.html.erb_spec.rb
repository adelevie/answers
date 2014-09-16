require 'spec_helper'

RSpec.describe "questions/index", :type => :view do
  before(:each) do
    assign(:questions, [
      Answers::Question.create!(),
      Answers::Question.create!()
    ])
  end

  it "renders a list of questions" do
  	pending 'Need to update for new engine layout.'

    render
  end
end
