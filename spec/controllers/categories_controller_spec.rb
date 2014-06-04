require 'spec_helper'

describe CategoriesController do
  render_views

  describe 'GET show' do
  	context 'when the article exists' do
  		let(:category) { create(:category) }

  		it 'renders the :show template when the arti' do
      	get(:show, id: category.slug)

	      expect(response).to render_template(:show)
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
