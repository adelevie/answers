require 'spec_helper'

RSpec.describe TagsController, type: :feature do
  context "When tags exist" do
    let(:tag_name)  { "Sampletag" }
    let(:tag)       { create(:tag, name: tag_name) }
    let(:tags) do
      [tag, create(:tag), create(:tag), create(:tag)]
    end
    
    before(:each) do
      #create(:tag, id: 1, name: tag_name)
      9.times do
        create(:tag)
      end
    end
    
    describe "GET index" do
    
      it "displays a list of links to tag pages" do
        allow(ActsAsTaggableOn::Tag).to(receive(:all)).and_return(tags)
        
        visit tags_path
        expect(page).to(have_content("Listing of All Tags"))
        css = "ul#tags"
        expect(page).to(have_css(css))
      end
      
    end

    describe "GET show" do
      it "returns http success" do
        allow(ActsAsTaggableOn::Tag).to(receive(:find).with(tag.id)).and_return(tag)
        
        visit tag_path(tag)
        expect(page).to(have_content(tag_name))
      end
    end
  
  end

end
