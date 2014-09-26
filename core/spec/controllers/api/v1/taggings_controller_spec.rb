require 'spec_helper'

RSpec.describe Answers::Api::V1::TaggingsController, :type => :controller do
  routes { Answers::Core::Engine.routes }

  # This should return the minimal set of attributes required to create a valid
  # ActsAsTaggableOn::Tag. As you add validations to ActsAsTaggableOn::Tag, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      tag_id: 1,
      taggable_id: 5,
      taggable_type: 'Question',
      tagger_id: 10,
      context: 'Context'
    }
  }

  let(:invalid_attributes) {
    {
      tag_id: 1,
      taggable_id: 5,
      taggable_type: 'Question',
      tagger_id: 10,
      context: 'Context',
      not_a_valid_attribute: 'invalid'
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ActsAsTaggableOn::TagsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all taggings as @taggings" do
      controller do
        controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"
        tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:taggings)).to eq([tagging])
      end
    end
  end

  describe "GET show" do
    it "assigns the requested tagging as @tagging" do
      controller do
        controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"
        tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
        get :show, {:id => tagging.to_param}, valid_session
        expect(assigns(:tagging)).to eq(tagging)
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ActsAsTaggableOn::Tag" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"        
          expect {
            post :create, {:tagging => valid_attributes}, valid_session
          }.to change(ActsAsTaggableOn::Tagging, :count).by(1)
        end
      end

      it "assigns a newly created tagging as @tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"        
          post :create, {:tagging => valid_attributes}, valid_session
          expect(assigns(:tagging)).to be_a(ActsAsTaggableOn::Tagging)
          expect(assigns(:tagging)).to be_persisted
        end
      end

      it "redirects to the created tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"        
          post :create, {:tagging => valid_attributes}, valid_session
          expect(response).to redirect_to(ActsAsTaggableOn::Tagging.last)
        end
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tagging as @tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"
          post :create, {:tagging => invalid_attributes}, valid_session
          expect(assigns(:tagging)).to be_a_new(ActsAsTaggableOn::Tagging)
        end
      end

      it "re-renders the 'new' template" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers"        
          post :create, {:tagging => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        {
          tag_id: 1,
          taggable_id: 5,
          taggable_type: 'Question',
          tagger_id: 10,
          context: 'NewContext'
        }
      }

      it "updates the requested tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
          tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
          put :update, {:id => tagging.to_param, :tagging => new_attributes}, valid_session
          tagging.reload
          expect(tagging.context).to(eq('NewContext'))
        end
      end

      it "assigns the requested tagging as @tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
          tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
          put :update, {:id => tagging.to_param, :tagging => valid_attributes}, valid_session
          expect(assigns(:tagging)).to eq(tagging)
        end
      end

      it "redirects to the tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
          tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
          put :update, {:id => tagging.to_param, :tagging => valid_attributes}, valid_session
          expect(response).to redirect_to(tagging)
        end
      end
    end

    describe "with invalid params" do
      it "assigns the tagging as @tagging" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
          tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
          put :update, {:id => tagging.to_param, :tagging => invalid_attributes}, valid_session
          expect(assigns(:tagging)).to eq(tagging)
        end
      end

      it "re-renders the 'edit' template" do
        controller do
          controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
          tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
          put :update, {:id => tagging.to_param, :tagging => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tagging" do
      controller do
        controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
        tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
        expect {
          delete :destroy, {:id => tagging.to_param}, valid_session
        }.to change(ActsAsTaggableOn::Tagging, :count).by(-1)
      end
    end

    it "redirects to the taggings list" do
      controller do
        controller.prepend_view_path "#{Rails.root}/answers/core/app/views/answers/api/v1/answers" 
        tagging = ActsAsTaggableOn::Tagging.create! valid_attributes
        delete :destroy, {:id => tagging.to_param}, valid_session
        expect(response).to redirect_to(taggings_url)
      end
    end
  end

end
