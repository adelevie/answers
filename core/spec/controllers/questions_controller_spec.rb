require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Answers::QuestionsController, :type => :controller do
  routes { Answers::Core::Engine.routes}

  # This should return the minimal set of attributes required to create a valid
  # Question. As you add validations to Question, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
      text: "Question text",
      in_language: "english"
    }
  }
  
  let(:question) {
    create(:question)
  }
  
  let(:questions) {
    [question]
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # QuestionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all questions as @questions" do
      get :index, {}, valid_session
      expect(assigns(:questions)).to(eq(questions))
    end
    
    it "renders the correct template" do
      question = Answers::Question.create! valid_attributes
      get :index, {}, valid_session
      expect(response).to(render_template('answers/questions/index'))
    end
  end

  describe "GET show" do
    # Normally this would be a good spot to test 'assigns'.
    # However, since this action sets no instance variables,
    # it's impossible to test. 
    # Instead we rely on spec/features/questions_spec.rb to
    # test the output from the QuestionsController and 
    # corresponding templates.
    
    it "renders the correct template" do
      allow(Answers::Question).to(receive(:find)).and_return(create(:question, id: 1))
      allow_any_instance_of(Answers::Question).to(receive(:similar)).and_return([])
      get :show, {id: 1}, valid_session
      expect(response).to(render_template('answers/questions/show'))
    end
  end

end
