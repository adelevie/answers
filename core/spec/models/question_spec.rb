require 'spec_helper'

RSpec.describe Answers::Question, :type => :model do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  context "when an accepted answer exists" do
    it "should return the top answer" do
      question.answers << answer

      question.save
      expect(question.top_answer).to be_valid
    end
  end

  context "top_answer" do
    let(:question) { create(:question) }

    it "should return nil" do
      expect(question.top_answer).to be_nil
    end
  end
  
  context "tagging" do
    let(:question1) { create(:question) }
    let(:tags) do
      5.times.map { |n| create(:tag) }
    end
    
    
    it "should have a tag_list" do      
      expect(question1).to(respond_to(:tag_list))
      expect(question1.tag_list).to(be_a(Array))
    end
    
    context "when tags are loaded" do
      let(:tags) do
        5.times.map { |n| create(:tag) }
      end
      before(:each) do
        allow(Answers::Question).to(receive(:tag_counts_on)).with(:tags).and_return(tags)
      end
      
      it "should return an empty Array" do
        my_tags = Answers::Question.tags
        expect(my_tags).to(be_a(Array))
        expect(my_tags.length).to(eq(tags.length))
      end
    end
    
    context "when no tags are loaded" do
      let(:tags) { [] }
      before(:each) do
        allow(Answers::Question).to(receive(:tag_counts_on)).with(:tags).and_return(tags)
      end
      
      it "should return an empty Array" do
        my_tags = Answers::Question.tags
        expect(my_tags).to(be_a(Array))
        expect(my_tags.length).to(eq(0))
      end
    end
    
  end

  context "slug" do
    let(:question) { create(:question, text: 'I can haz # ~ ! ____a slug?!??????' ) }

    it 'returns a hyphenated URI string' do
      expect(question.slug).to eq('i-can-haz-____a-slug')
    end
  end

end
