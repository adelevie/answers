require 'spec_helper'

describe Keyword, :type => :model do
  describe "after create with a keyword with the name 'example'" do
    let(:keyword)           { FactoryGirl.create(:keyword, name: 'example') }
    let(:returned_synonyms) { ["illustration", "instance", "representative",
              "model", "exemplar", "good example", "deterrent example",
              "lesson", "object lesson", "case", "exercise", "admonition",
              "happening", "ideal", "information", "internal representation",
              "mental representation", "monition", "natural event",
              "occurrence", "occurrent", "representation", "warning",
              "word of advice"] }

    it "sets a metaphone of 'equal'" do
      expect(keyword.metaphone).to eq(["AKSM", nil])
    end
  end
end
