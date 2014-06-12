require 'spec_helper'

describe 'Categories' do
  describe 'user views a category page' do
  	let(:category) { create(:category, name: 'parking', description: 'Foo') }

    it 'displays category details' do
      visit category_path(category)
      expect(page).to have_content('parking')
      expect(page).to have_content('Foo')
    end

    it 'links to other categories in the sidebar using the slugged url' do
      other_category = create(:category, 
                              name: Faker::Lorem.words(3).join(' ').titleize,
                              description: Faker::Lorem.sentence)
      
      visit category_path(category)
      expect(page).to have_content(other_category.name)
      expect(page.html.include?(other_category.slug)).to be true
    end
    
    it 'displays properly formated breadcrumbs' do
    	category = create(:category, name: 'parking', description: 'Foo')
    	visit category_path(category)
    	expect(page.html).to have_tag('div.breadcrumbs ol li')
    end
    
  end
  
  describe 'categories listing' do
    before { 6.times { create(:category_with_articles, name: Faker::Lorem.word) } }

    it 'displays a list of all category names' do
      create(:category_with_articles)
      visit categories_path

      Category.all.map(&:name).each { |name| expect(page).to have_content(name) }
    end
  end

  describe 'category show view' do
    let(:category) { create(:category_with_articles) }
    let(:article) { category.articles.first }
    before { visit category_path(category) }

    it 'displays the category name and the description' do
      expect(page).to have_content(category.name)
      expect(page).to have_content(category.description)
    end

    it 'displays any published articles for that category and their preview' do
      expect(page).to have_content(article.title)
      expect(page).to have_content(article.preview)
    end

  end

  describe 'user views the categories index page' do
  	it 'displays formated breadcrumbs' do
  		path = '/categories'
	  	visit path
	  	expect(page.html).to have_tag('div.breadcrumbs ol li')
  	end
  end

end
