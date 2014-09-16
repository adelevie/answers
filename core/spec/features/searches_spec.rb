
require 'spec_helper'

describe'Searches', type: :feature do

  describe 'search results', vcr: true do
       
    let(:question) { create :question }
    let(:query) { question.text.downcase.gsub!(/[^\w ]*/, '') }
    
    context '1 result found' do
      before do
        allow(Answers::Question).to receive(:search) { [question] }
        visit answers_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{query}\"" }
    end

    context 'no results found' do
      let(:reverse_query) { "foo" }

      before do
        # allow(Article).to receive(:search) { [] }
        allow(Answers::Question).to receive(:search) { [] }
        visit answers_path
        fill_in 'query', :with => reverse_query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{reverse_query}\"" }
      it { is_expected.to have_content "Sorry, no results found for \"#{reverse_query}\".  Please try rephrasing your search terms." }
    end

    context 'several results found' do
      let(:question_1) { create(:question) }
      let(:question_2) { create(:question) }
      let(:query)     { 'best nice' }

      before do
        allow(Answers::Question).to receive(:search) { [question_1, question_2] }
        visit answers_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it 'show the query' do
        expect(page).to have_content "Search results for: \"#{query}\""
      end

      it 'should contain the title and preview of both articles' do
        expect(page).to have_content question_1.text
        expect(page).to have_content question_2.text
      end
      
    end
  end
end
