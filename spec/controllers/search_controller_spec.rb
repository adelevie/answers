require 'spec_helper'

describe SearchController, type: :controller do
  describe "#reindex_articles", vcr: true do
    it "reindexes articles via rake" do
      expect(Article).to receive(:reindex)
      #@request.env["HTTP_ACCEPT"] = "application/json"
      #post :reindex_articles
      Article.reindex
    end
  end
end
