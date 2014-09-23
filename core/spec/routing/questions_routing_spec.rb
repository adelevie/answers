require "spec_helper"

RSpec.describe Answers::QuestionsController, :type => :routing do
  describe "routing" do
    routes { Answers::Core::Engine.routes }

    it "routes to #index" do
      expect(get: '/answers').to(
        route_to(controller: 'answers/questions', action: 'index')
      )
    end

    it "routes to #show" do
      expect(get: '/answers/1').to(
        route_to(controller: 'answers/questions', action: 'show', id: '1')
      )
    end

  end
end
