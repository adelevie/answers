require 'spec_helper'

describe SearchController, vcr: true do

  describe 'GET index' do
  	it 'redirects to the homepage if no query exists' do
  		get :index, :q => ""

  		expect(response).to redirect_to(root_url)
  	end

  end
end
