require 'spec_helper'

describe ContactsController, :type => :controller do

  describe 'GET index' do
    let(:contact) { create(:contact) }
    let(:another_contact) { create(:contact) }

    it 'renders the :index template' do
      get :index

      expect(response).to render_template :index
    end

  end

  describe 'GET show' do
    let(:contact) { create(:contact) }

    it 'renders the :show template' do
      get :show, id: contact.id

      expect(response).to render_template :show
    end
  end

end
