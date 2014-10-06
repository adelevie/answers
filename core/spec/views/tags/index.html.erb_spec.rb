require 'spec_helper'

RSpec.describe "tags/index.html.erb", :type => :view do
  before(:each) do
    words = %w[
      pets cars education transportation business employment housing trash
    ]

    tags = words.map do |word|
      create(:tag, name: word)
    end

    100.times do
      q = create(:question)
      q.tag_list = [tags.sample]
      q.save
    end
  end

  it "renders tags" do
    controller do
      render
    end
  end

end
