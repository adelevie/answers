require 'spec_helper'

describe ArticlesController do
  render_views

  describe 'GET index' do
    let(:category) { create(:category_with_articles) }
    let(:another_category) { create(:category_with_articles) }
    before { get :index }

    it 'assigns the body html class to @bodyclass' do
      assigns(:bodyclass).should eq('results')
    end

    it 'assigns a list of categories organized by access count to @categories' do
      assigns(:categories).should eq(Category.by_access_count)
    end

    it 'renders the :index template' do
			expect(response).to render_template :index
    end

  end

  describe 'GET show' do
    let(:article) { FactoryGirl.create :article }

    it 'assigns Article.find(article) to @article' do
      get :show, id: article.slug

      assigns(:article).should eq(article)
    end
  end
  
  describe "GET article_type" do
    let(:article) { create :article, type: "QuickAnswer" }
    
    it "renders a list of Articles of a given article_type" do
      get :article_type, content_type: "QuickAnswer"
      assigns(:article_type)
      assigns(:articles)
    end
  end

end
