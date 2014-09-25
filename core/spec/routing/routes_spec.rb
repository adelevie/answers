require 'spec_helper'

describe "routing to search results", type: :routing do
  routes { Answers::Core::Engine.routes }

  it "routes /search to search#index for a given query" do
    expect(get: '/search').to(
      route_to(controller: 'answers/search', action: 'index')
    )
  end

  it "routes /about to home#about" do
    expect(get: '/about').to(
      route_to(controller: 'answers/home', action: 'about')
    )
  end

end