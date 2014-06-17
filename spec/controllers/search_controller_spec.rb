require 'spec_helper'

describe SearchController, :type => :controller do
  describe "#reindex_articles" do
    it "reindexes articles via tanker" do
      expect(Article).to receive(:tanker_reindex)
      @request.env["HTTP_ACCEPT"] = "application/json"
      post :reindex_articles
    end
  end
end
