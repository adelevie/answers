require 'spec_helper'

RSpec.describe Answers::Api::V1::TagsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # ActsAsTaggableOn::Tag. As you add validations to ActsAsTaggableOn::Tag, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      #tag: "meaning of life",
      name: "great answers",
      taggings_count: 1,
    }
  }

  let(:invalid_attributes) {
      {
        tag: "Why?",
        name: "bad answers",
        taggings_count: 1,
        invalid: "invalid test case",
      }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ActsAsTaggableOn::TagsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all tags as @tags" do
      controller do
        tag = ActsAsTaggableOn::Tag.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:tags)).to eq([tag])
      end
    end
  end

  describe "GET show" do
    it "assigns the requested tag as @tag" do
      controller do
        tag = ActsAsTaggableOn::Tag.create! valid_attributes
        get :show, {:id => tag.to_param}, valid_session
        expect(assigns(:tag)).to eq(tag)
      end
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ActsAsTaggableOn::Tag" do
        controller do
          expect {
            post :create, {:tag => valid_attributes}, valid_session
          }.to change(ActsAsTaggableOn::Tag, :count).by(1)
        end
      end

      it "assigns a newly created tag as @tag" do
        controller do
          post :create, {:tag => valid_attributes}, valid_session
          expect(assigns(:tag)).to be_a(ActsAsTaggableOn::Tag)
          expect(assigns(:tag)).to be_persisted
        end
      end

      it "redirects to the created tag" do
        controller do
          post :create, {:tag => valid_attributes}, valid_session
          expect(response).to redirect_to(ActsAsTaggableOn::Tag.last)
        end
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved tag as @tag" do
        controller do
          post :create, {:tag => invalid_attributes}, valid_session
          expect(assigns(:tag)).to be_a_new(ActsAsTaggableOn::Tag)
        end
      end

      it "re-renders the 'new' template" do
        controller do
          post :create, {:tag => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested tag" do
        controller do
          tag = ActsAsTaggableOn::Tag.create! valid_attributes
          put :update, {:id => tag.to_param, :tag => new_attributes}, valid_session
          tag.reload
          skip("Add assertions for updated state")
        end
      end

      it "assigns the requested tag as @tag" do
        controller do
          tag = ActsAsTaggableOn::Tag.create! valid_attributes
          put :update, {:id => tag.to_param, :tag => valid_attributes}, valid_session
          expect(assigns(:tag)).to eq(tag)
        end
      end

      it "redirects to the tag" do
        controller do
          tag = ActsAsTaggableOn::Tag.create! valid_attributes
          put :update, {:id => tag.to_param, :tag => valid_attributes}, valid_session
          expect(response).to redirect_to(tag)
        end
      end
    end

    describe "with invalid params" do
      it "assigns the tag as @tag" do
        controller do
          tag = ActsAsTaggableOn::Tag.create! valid_attributes
          put :update, {:id => tag.to_param, :tag => invalid_attributes}, valid_session
          expect(assigns(:tag)).to eq(tag)
        end
      end

      it "re-renders the 'edit' template" do
        controller do
          tag = ActsAsTaggableOn::Tag.create! valid_attributes
          put :update, {:id => tag.to_param, :tag => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested tag" do
      controller do
        tag = ActsAsTaggableOn::Tag.create! valid_attributes
        expect {
          delete :destroy, {:id => tag.to_param}, valid_session
        }.to change(ActsAsTaggableOn::Tag, :count).by(-1)
      end
    end

    it "redirects to the tags list" do
      controller do
        tag = ActsAsTaggableOn::Tag.create! valid_attributes
        delete :destroy, {:id => tag.to_param}, valid_session
        expect(response).to redirect_to(tags_url)
      end
    end
  end

end
