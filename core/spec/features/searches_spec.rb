
require 'spec_helper'

describe'Searches', type: :feature do

  describe 'search results', vcr: true do
       
    #let(:article) { create :article, status: 'Published' }
    let(:question) { create :question }
    let(:query) { question.text.downcase.gsub!(/[^\w ]*/, '') }
    
    context '1 result found' do
      before do
        # allow(Article).to receive(:search) { [article] }
        allow(Answers::Question).to receive(:search) { [question] }
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{query}\"" }
      # it { is_expected.to have_content article.title }
      # it { is_expected.to have_content article.preview }
    end

    context 'no results found' do
      let(:reverse_query) { "foo" }

      before do
        # allow(Article).to receive(:search) { [] }
        allow(Answers::Question).to receive(:search) { [] }
        visit root_path
        fill_in 'query', :with => reverse_query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{reverse_query}\"" }
      it { is_expected.to have_content "Sorry, no results found for \"#{reverse_query}\".  Please try rephrasing your search terms." }
      # it { is_expected.not_to have_content article.title }
    end

    context 'several results found' do
      # let(:article_1) { create(:article) }
      # let(:article_2) { create(:article) }
      let(:question_1) { create(:question) }
      let(:question_2) { create(:question) }
      let(:query)     { 'best nice' }

      before do
        # Article.reindex
        # allow(Article).to receive(:search) { [article_1, article_2] }
        allow(Answers::Question).to receive(:search) { [question_1, question_2] }
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it 'show the query' do
        expect(page).to have_content "Search results for: \"#{query}\""
      end

      it 'should contain the title and preview of both articles' do
        # expect(page).to have_content article_1.title
        # expect(page).to have_content article_1.preview
        # expect(page).to have_content article_2.title
        # expect(page).to have_content article_2.preview
      end
      
    end
  end

  describe 'search results for a tag' do
    let(:tag) {create(:tag)}
    let(:questions) { create_list(:question, 3) }
    let(:results) { questions }
    
    context 'Question found for tag' do
      
      before do
        allow(Question).to receive(:search) { results }
        visit tag_search_path(:tag => tag)
      end

      subject { page }

      it 'question links are on page' do
      is_expected.to have_content "Questions related to:"
      
      results.each { |result|
        should have_link("#{result.text}")
      }
      end
    end
  end
end













