require 'spec_helper'

describe ArticlesController, :type => :controller do
  render_views

  describe 'GET index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
      expect(response.body).to(have_tag("body", with: {class: "results"}))
    end
  end

  describe 'GET show' do
    let(:article) { FactoryGirl.create(:article) }
    it 'redirects to the quick_answer_path' do
      get :show, id: article.slug
      expect(response).to redirect_to(quick_answer_path(article))
    end
  end
  
  describe "GET article_type" do
    it 'renders the :article_type template' do
      get :article_type, content_type: "QuickAnswer"
      expect(response).to render_template :article_type
    end
  end

end
