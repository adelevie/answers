require "spec_helper"

RSpec.describe Answers::QuestionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
    	pending 'needs to be fixed for new engine layout'

      expect(:get => "/answers").to route_to("questions#index")
    end

    it "routes to #show" do
      pending 'needs to be fixed for new engine layout'

      expect(:get => "/answers/1").to route_to("questions#show", :id => "1")
    end

  end
end
