
require 'spec_helper'

describe'Searches', type: :feature do

  describe 'search results', vcr: true do
       
    #let(:article) { create :article, status: 'Published' }
    let(:question) { create :question }
    let(:query) { question.text.downcase.gsub!(/[^\w ]*/, '') }

    context '1 result found' do
      let(:results)  { [question] }

      before do
        # allow(Article).to receive(:search) { [article] }
        allow(Question).to receive(:search) {results}
        allow(results).to receive(:first_page?) {true}
        allow(results).to receive(:last_page?) {true}
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
      let(:results)  { [] }
      
      before do
        # allow(Article).to receive(:search) { [] }
        allow(Question).to receive(:search) { results }
        visit root_path
        fill_in 'query', :with => reverse_query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{reverse_query}\"" }
      it { is_expected.to have_content "Sorry, no results found for \"#{reverse_query}\".  Please try rephrasing your search terms." }
      # it { is_expected.not_to have_content article.title }
    end

    context 'three results found' do
      # let(:article_1) { create(:article) }
      # let(:article_2) { create(:article) }
      let(:questions) { create_list(:question, 3) }
      let(:query)     { 'best nice' }
      let(:results)  { questions }
      
      before do
        # Article.reindex
        # allow(Article).to receive(:search) { [article_1, article_2] }
        allow(Question).to receive(:search) { results }
        allow(results).to receive(:first_page?) {true}
        allow(results).to receive(:last_page?) {true}

        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it 'show the query' do
        expect(page).to have_content "Search results for: \"#{query}\""
      end
      
      subject { page }

      it 'links show up on page' do
        results.each { |result|
          should have_link("#{result.text}", href: answer_path(result.id)) 
        }
      end

      it 'should contain the title and preview of both articles' do
        # expect(page).to have_content article_1.title
        # expect(page).to have_content article_1.preview
        # expect(page).to have_content article_2.title
        # expect(page).to have_content article_2.preview
      end
      
    end
  end
end
