require 'spec_helper'

RSpec.describe "questions/show", :type => :view do
  before(:each) do
    @question = assign(:question, Question.create!())
  end

  it "renders attributes in <p>" do
    render :partial => "shared/tags_sidebar.html.erb", :locals => {:question => @question}
  end
end