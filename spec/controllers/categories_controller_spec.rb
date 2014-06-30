require 'spec_helper'

describe CategoriesController, :type => :controller do
  render_views
  
  describe 'GET index' do
    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
      expect(response.body).to(have_tag("body", with: {class: "results"}))
    end
  end

  describe 'GET show' do
  	context 'when the article exists' do
  		let(:category) { create(:category) }

  		it 'renders the :show template when the arti' do
      	get(:show, id: category.slug)

	      expect(response).to render_template(:show)
        expect(response.body).to(have_tag("body", with: {class: "results"}))
  	  end
		end # context

		context 'when the article does not exist' do
  		it 'renders the :missing template' do
      	get(:show, id: 'this-category-does-not-exist')

	      expect(response).to render_template(:missing)
  	  end
  	end # context

  end # describe
end # describe
