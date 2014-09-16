require 'spec_helper'

RSpec.describe Answers::HomeController, :type => :feature do

  # This should return the minimal set of attributes required to create a valid
  # Answer. As you add validations to Answer, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AnswersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

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

  describe "GET index" do    
    it "displays a list of top Tags" do
      visit "/"
      # check for basic text
      expect(page).to(have_content("Most Popular Tags"))
      # check for div
      expect(page).to(have_tag("div#tags"))
      
      div_children = 4  # four tags listed
      p_children = 3    # three links per tag
      
      div_children.times do |div_child|
        expect(page).to(have_css("#tags > div:nth-child(#{div_child+1}) > span > a"))

        p_children.times do |p_child|
          expect(page).to(have_css("#tags > div:nth-child(#{div_child+1}) > ul > p:nth-child(#{p_child+1}) > a"))
        end
      end
    end
  end

end
