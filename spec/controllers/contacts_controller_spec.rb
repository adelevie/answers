require 'spec_helper'

describe ContactsController do

  describe 'GET index' do
    let(:contact) { create(:contact) }
    let(:another_contact) { create(:contact) }

    it 'assigns Contact.all to @categories' do
      get :index

      assigns(:contacts).should eq(Contact.all)
    end

    it 'renders the :index template' do
      get :index

      expect(response).to render_template :index
    end

  end

  describe 'GET show' do
    let(:contact) { create(:contact) }

    it 'assigns Contact.find(contact) to @contact' do
      get :show, id: contact

      assigns(:contact).should eq(contact)
    end
  end

end
