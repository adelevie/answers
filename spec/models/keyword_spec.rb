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

    before do
      allow(BigHugeThesaurus).to receive(:synonyms).and_return(returned_synonyms)
    end

    it "sets a metaphone of 'equal'" do
      expect(keyword.metaphone).to eq(["AKSM", nil])
    end

    it "set an array synonyms of 'example'" do
      expect(keyword.synonyms).to eq(returned_synonyms)
    end
  end
end
