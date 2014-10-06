require 'spec_helper'

RSpec.describe Answers::TagsController, type: :feature do
  context "When tags exist" do
    let(:tags) { [create(:tag), create(:tag)] }
    let(:question) { create(:question) }

    before do
      # associate tags with questions!
      question.tags << tags
      question.save
    end

    describe "GET index" do
    
      it "displays a list of links to tag pages" do
        visit answers.tags_path
        expect(page).to(have_content("Listing of All Tags"))
        css = "ul#tags"
        expect(page).to(have_css(css))
        
        tags.each {|tag| expect(page).to have_content tag.name.titleize }
      end
      
    end

    describe "GET show" do
      it "returns http success" do
        tag = tags.sample
        allow(ActsAsTaggableOn::Tag).to(receive(:find).with(tag.name)).and_return(tag)
        visit answers.tag_path(tag)
        expect(page).to(have_content(tag.name.titleize))
      end
    end
  
  end

end
