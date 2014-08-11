require "spec_helper"

RSpec.describe QuestionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/answers").to route_to("questions#index")
    end

    it "routes to #show" do
      expect(:get => "/answers/1").to route_to("questions#show", :id => "1")
    end

  end
end
