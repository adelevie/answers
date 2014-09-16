require 'spec_helper'

RSpec.describe "questions/index", :type => :view do
  before(:each) do
    assign(:questions, [
      Answers::Question.create!(),
      Answers::Question.create!()
    ])
  end

  it "renders a list of questions" do
    render
  end
end
