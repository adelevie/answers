require 'spec_helper'

describe Article, type: :model, vcr: true do
  let(:article) { FactoryGirl.create(:article) }
  before do
    Article.reindex
    allow(Article).to receive(:search).and_return([article]) 
  end
  subject       { article }


  it "is valid with a title" do
    expect(article).to be_valid
  end

  it "has a friendly url" do
    article = Article.new(
        :title => "How to build an answer engine",
      )

    article.save

    expect(article.slug).to eq("how-to-build-an-answer-engine")
  end

  describe 'can be published' do
    context 'an unpublished article' do
      let(:unpublished_article) { FactoryGirl.create(:article) }

      it 'returns status Published' do
        unpublished_article.publish

        expect(unpublished_article.status).to eq('Published')
      end

      it 'is published' do
        unpublished_article.publish

        expect(unpublished_article.published?).to be true
      end
    end
  end

  describe '.delete_orphaned_keywords' do
    context 'updating an article' do
      it 'destroys orphaned keywords associated' do
        article = Article.create(
            :title => 'Cats are cats'
          )

        article.title = 'Dachshunds are dogs'

        article.save

        expect(article.keywords).to_not include 'dogs'
      end
    end

    context 'when deleting an article' do
      it 'destroys all keywords associated' do
        article = Article.create(
            :title => 'Cats have tails'
          )
        
        expect(article.keywords).to be_empty
      end
    end

  end

  # related articles no longer implemented
  # https://github.com/codeforamerica/oakland_answers/commit/36236fbe803b86ec0bc9e9cf5c8f07501432b026
  describe '.related' do
    subject  { article.related }
    context 'has no related articles' do

      it { is_expected.to be_nil }
    end

    context 'has related articles' do
      it { is_expected.to be_nil }

    end
  end

  describe ".hits" do
    context 'before an article has been viewed' do
      let(:new_article) { FactoryGirl.create(:article) }

      it 'has zero hits' do
        expect(new_article.hits).to eq(0)
      end
    end

    context 'returns number of views' do
      let(:old_article) { FactoryGirl.create(:article) }

      it 'has seven views' do
        old_article.access_count = 7
        old_article.save

        expect(old_article.hits).to eq(7)
      end

    end
  end

  describe '.record_hit' do
    context 'viewing an article' do
      it 'increases hit by one' do
        count = article.hits
        article.record_hit

        expect(article.hits).to eq(count+1)
      end
    end
  end

  describe ".search" do

    it "matches articles in the database" do
      expect(Article.search(article.title)).to include(article)
    end

    context "query does not match anything in the database" do
      it "returns an empty array" do
        allow(Article).to receive(:search).and_return([])
        expect(Article.search(SecureRandom.hex(16))).to be_empty
      end
    end

    context "query is an empty string" do
      subject { Article.search ''}
      it { is_expected.to eq(Article.all) }
    end

    context "query is a single space" do
      subject { Article.search ' ' }
      it { is_expected.to eq(Article.all) }
    end

    describe ".search titles" do
      it "returns an empty array when the search term is present in an article but not the title" do
        allow(Article).to receive(:search).and_return([])
        expect(Article.search_titles(article.preview)).to be_empty
      end

      context "query is present in the title" do
        subject { Article.search_titles article.title }
        it { is_expected.to include(article) }
      end
    end
  end

  describe "#remove_stop_words" do
    it "removes common english words from the string" do
      expect(Article.remove_stop_words('why am I a banana')).to eq('banana')
    end
  end

  describe ".find_by_type" do
    it 'returns articles matching type' do
      new_article = Article.create(
          :title => "Every answer you've ever been searching for and a bag of cats"
        )
      new_article.update_attribute(:type, "QuickAnswer")

      result = Article.find_by_type( "QuickAnswer" )

      expect(result.map{|r| r.title }).to include "Every answer you've ever been searching for and a bag of cats"
      expect(result.map{|r| r.type }).to include "QuickAnswer"
    end

    it 'excludes articles not matching specified type' do
      new_article = Article.create(
          :title => "Just a bag of cats"
        )
      new_article.update_attribute(:type, "Bag")

      result = Article.find_by_type( "QuickAnswer" )

      expect(result.map{|r| r.type }).to_not include "Bag"
    end
  end

  describe '.to_s' do
    context 'when an article has a category' do
      it 'returns a string containing title, id and category' do
        category = create(:category)
        article.category = category
        article.save

        expect(article.to_s).to eq("#{article.title} (#{article.id}) [#{category.name}]")
      end
    end
  end


  describe '.legacy?' do
    it 'returns true if render_markdown is false' do
      article.render_markdown = true
      article.save

      expect(article.legacy?).to eq(false)
    end
  end

  describe '.indexable?' do
    it 'returns true if article is published' do
      article.publish

      expect(article.indexable?).to eq(true)
    end

    it 'returns false if article is not published' do
      article.status = 'Merp'
      article.save

      expect(article.indexable?).to eq(false)
    end
  end

  describe '#before_validation' do
    it 'sets access count if nil' do
      not_accessed_article = Article.create(
          :title => "Forever alone article"
        )

      expect(not_accessed_article.access_count).to eq(0)
    end
  end

  describe '#find_by_friendly_id' do
    context 'when an article exists' do
      it 'returns the corresponding article' do
        find_this = Article.create(
            :title => "Convert this to a 123 Useful slug! $"
          )

        result = Article.find_by_friendly_id('convert-this-to-a-123-useful-slug')

        expect(result.id).to eq(find_this.id)
      end
    end

    context 'when an article does not exist' do
      it 'does not raise an exception' do
        expect {
            Article.find_by_friendly_id('5a8605c8bbe63767c705da93522a6f0f1b8a89f814ce2f2f921e29c81eed31624db97d744ea0fe37f6cd32280ab37f63f4352fbb7802a18adeb03af70f96cee7')
          }.not_to raise_error
      end
    end
  end

end
