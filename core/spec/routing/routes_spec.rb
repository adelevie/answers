require 'spec_helper'

describe "routing to search results", :type => :routing do
  it "routes /search/ to search#index for a given query" do
  	pending 'needs to be fixed for new engine layout'

    expect({ :get => "/search/" }).to route_to(
      :controller => 'search',
      :action => 'index'
    )
  end

end