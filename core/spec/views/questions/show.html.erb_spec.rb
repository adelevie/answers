require 'spec_helper'

RSpec.describe "questions/show", :type => :view do
  before(:each) do
    @question = assign(:question, Answers::Question.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
