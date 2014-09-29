require 'spec_helper'

RSpec.describe "tags/index.html.erb", :type => :view do
  before(:each) do
    assign(:question,[
      Answers::Question.create!()
    ])
  end

  it "renders tags" do
    controller do
      render
    end
  end

end
