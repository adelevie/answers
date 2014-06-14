require 'spec_helper'

describe 'Articles', :type => :feature do

  describe 'user views a quick answer details page' do
    let(:title)                { 'Parking in Oakland' }
    let(:content_main)         { 'Learn about parking' }
    let(:article) { create(:article, 
                           type: 'QuickAnswer',
                           title: title,
                           content_main: content_main) }
    
    before { visit article_path(article) }

    it 'displays the quick answer title' do
      expect(page).to have_content(title)
    end

    it 'displays the main content' do
      expect(page).to have_content(content_main)
    end

    it 'displays properly formated breadcrumbs' do
      skip 'currently creation of generic articles is disabled.'
      expect(page.html).to have_tag('div#breadcrumbs ol li')
    end
  end

  describe 'user views the quick answers list page' do
    before do
      parking_category = create(:category, name: 'parking')
      camping_category = create(:category, name: 'camping')
  
      create(:article, 
             type: 'QuickAnswer',
             category: parking_category,
             title: 'first parking')
  
      create(:article,
             type: 'QuickAnswer',
             category: parking_category,
             title: 'second parking')
  
      create(:article,
             type: 'QuickAnswer',
             category: camping_category,
             title: 'just camping',
             preview: 'I like camping')
      
      visit articles_type_path('quick-answer')
    end

    it 'displays the categories as headers' do
      expect(page).to have_selector('h1 a', text: 'parking')
      expect(page).to have_selector('h1 a', text: 'camping')
    end

    it 'has two quick answers under the the parking category' do
      expect(page).to have_css('ul.category-articles li.article-listing h2 a', text: 'first parking')
      expect(page).to have_css('ul.category-articles li.article-listing h2 a', text: 'second parking')
    end

    it 'has one quick answers under the camping category' do
      expect(page).to have_css('ul.category-articles li.article-listing h2 a', text: 'just camping')
      expect(page).to have_content('I like camping')
    end

    it 'displays the categories in the sidebar' do
      expect(page).to have_css('.sidebar-content ul li a', 'parking')
      expect(page).to have_css('.sidebar-content ul li a', 'camping')
    end
  end


  describe 'user views a guide details page' do
    let!(:guide) { create(:guide, 
                          title: 'trains',
                          content_main: 'trains are great') }

    let!(:step1) { create(:guide_step, 
                          title: 'first step',
                          step: 1,
                          article_id: guide.id,
                          content: 'do first') }

    let!(:step2) { create(:guide_step, 
                          title: 'second step',
                          step: 2,
                          article_id: guide.id,
                          content: 'do second') }

    before do
      visit guide_path(guide)
    end

    it 'shows the guide title' do
      expect(page).to have_content('trains')
    end

    it 'lists the steps in the sidebar' do
      expect(page).to have_css('#vtabs ul li a', text: '1. first step')
      expect(page).to have_css('#vtabs ul li a', text: '2. second step')
    end

    it 'lists the first step article header and preview' do
      expect(page).to have_css('div h2.vtab-content-header', text: 'first step')
      expect(page).to have_css('div p', text: 'do first')
    end

    it 'lists the second step article header and preview' do
      expect(page).to have_css('div h2.vtab-content-header', text: 'second step')
      expect(page).to have_css('div p', text: 'do second')
    end
  end

  describe 'user views the guides list page' do
    before do
      trains_category = create(:category, name: 'trains')
      planes_category = create(:category, name: 'planes')

      create(:guide,
             title: 'all about trains',
             category: trains_category,
             preview: 'trains preview')
      
      create(:guide,
             title: 'all about planes',
             category: planes_category,
             preview: 'planes preview')
      
      visit articles_type_path('guide')
    end

    it 'displays the categories as headers' do
      expect(page).to have_selector('h1 a', text: 'trains')
      expect(page).to have_selector('h1 a', text: 'planes')
    end

    it 'has two guides' do
      expect(page).to have_css('ul.category-articles li.article-listing h2 a', text: 'all about trains')
      expect(page).to have_content('trains preview')

      expect(page).to have_css('ul.category-articles li.article-listing h2 a', text: 'all about planes')
      expect(page).to have_content('planes preview')
    end
  end

  describe 'user views the web service details page' do
    let(:web_service) { create(:article, category: create(:category), type: 'WebService') }
    
    before do
      web_service.publish
      visit web_service_path(web_service)
    end

    it 'displays the web service title' do
      expect(page).to have_content(web_service.title)
    end

    it 'displays the web service content' do
      expect(page).to have_content(web_service.content_main)
    end

  end
end
