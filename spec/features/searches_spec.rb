require 'spec_helper'

describe 'Searches', :type => :feature do

  describe 'search results' do
    let(:article) { create :article, status: 'Published' }
    let(:query) { article.title.downcase.gsub!(/[^\w ]*/, '') }

    context '1 result found' do
      before do
        allow(Article).to receive(:search_tank) { [article] }
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{query}\"" }
      it { is_expected.to have_content article.title }
      it { is_expected.to have_content article.preview }
    end

    context 'no results found' do
      let(:reverse_query) { query.reverse*3 }

      before do
        allow(Article).to receive(:search_tank) { [] }
        visit root_path
        fill_in 'query', :with => reverse_query
        click_on 'SEARCH'
      end

      subject { page }

      it { is_expected.to have_content "Search results for: \"#{reverse_query}\"" }
      it { is_expected.to have_content "Sorry, no results found for \"#{reverse_query}\".  Please try rephrasing your search terms." }
      it { is_expected.not_to have_content article.title }
    end

    context 'several results found' do
      let(:article_1) { create(:article) }
      let(:article_2) { create(:article) }
      let(:query)     { 'best nice' }

      before do
        allow(Article).to receive(:search_tank) { [article_1, article_2] }
        visit root_path
        fill_in 'query', :with => query
        click_on 'SEARCH'
      end

      it 'show the query' do
        expect(page).to have_content "Search results for: \"#{query}\""
      end

      it 'should contain the title and preview of both articles' do
        expect(page).to have_content article_1.title
        expect(page).to have_content article_1.preview
        expect(page).to have_content article_2.title
        expect(page).to have_content article_2.preview
      end
    end
  end
end
