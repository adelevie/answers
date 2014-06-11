# encoding: utf-8
include ActionView::Helpers::SanitizeHelper
require 'facets/enumerable'

class Article < ActiveRecord::Base
  include TankerArticleDefaults
  include Tanker
  include RailsNlp
  include Markdownifier

  require_dependency 'keyword'

  extend FriendlyId

  # Permalinks. :slugged option means it uses the 'slug' column for the url
  #             :history option means when you change the article title, old slugs still work
  friendly_id :title, use: [:slugged, :history]

  belongs_to :contact
  belongs_to :category
  belongs_to :user
  has_many :wordcounts
  has_many :keywords, :through => :wordcounts

  scope :by_access_count, order('access_count DESC')
  scope :with_category, lambda { |category| where('categories.name = ?', category).joins(:category) }

  scope :published, lambda { where(status: "Published") }

  has_attached_file :author_pic,
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => {
      :access_key_id => ENV['S3_KEY'],
      :secret_access_key => ENV['S3_SECRET']
    },
    :path => "/:style/:id/:filename",
    :styles => { :thumb => "100x100" }

  validates_attachment_size :author_pic, :less_than => 5.megabytes
  validates_attachment_content_type :author_pic, :content_type => ['image/jpeg', 'image/png']

  validates_presence_of :access_count

  attr_accessible :title, :content, :content_md, :content_main, :content_main_extra,
    :content_need_to_know, :render_markdown, :preview, :contact_id, :tags,
    :is_published, :slugs, :category_id, :updated_at, :created_at, :author_pic,
    :author_pic_file_name, :author_pic_content_type, :author_pic_file_size,
    :author_pic_updated_at, :author_name, :author_link, :type, :service_url, :user_id, :status,
    :keyword_ids, :title_es, :preview_es, :content_main_es,
    :title_cn, :preview_cn, :content_main_cn

  # A note on the content fields:
  # *  Originally the content for the articles was stored as HTML in Article#content.
  # *  We then moved to Markdown for content storage, resulting in Article#content_md.
  # *  Most recently, the QuickAnswers were split into three distinct sections: content_main, content_main_extra and content_need_to_know. All these use Markdown.

  after_save :update_tank_indexes
  after_destroy :delete_tank_indexes

  handle_asynchronously :update_tank_indexes
  handle_asynchronously :delete_tank_indexes

  # query_magic callbacks to update keywords and wordcounts tables (The gem will be called query_magic --hale)
  after_create :qm_after_create
  after_update :qm_after_update
  after_destroy :qm_after_destroy

  before_validation :set_access_count_if_nil

  STOP_WORDS = ['a','able','about','across','after','all','almost','also','am','among','an','and','any','are','as','at','be','because','been','but','by','can','cannot','could','dear','did','do','does','either','else','ever','every','for','from','get','got','had','has','have','he','her','hers','him','his','how','however','i','if','in','into','is','it','its','just','least','let','like','likely','may','me','might','most','must','my','neither','no','nor','not','of','off','often','on','only','or','other','our','own','rather','said','say','says','she','should','since','so','some','than','that','the','their','them','then','there','these','they','this','tis','to','too','twas','us','wants','was','we','were','what','when','where','which','while','who','whom','why','will','with','would','yet','you','your']

  def legacy?
    !render_markdown
  end

  def self.find_by_friendly_id( friendly_id )
    begin
      find( friendly_id )
    rescue ActiveRecord::RecordNotFound => e
      Rails.logger.debug e.to_s
      nil
    end
  end

  def self.search( query )
    return Article.all if query.blank?
    self.search_tank query
  end

  def self.search_titles( query )
    return Article.all if query.blank?
    self.search_tank( '__type:Article', :conditions => {:title => query })
  end

  def self.find_by_type( content_type )
    return Article.where(:type => content_type).order('category_id').order('access_count DESC')
  end

  def to_s
    "#{self.title} (#{self.id}) [#{self.category.name}]" if self.category
  end

  def published?
    status == "Published"
  end

  def publish
    update_column(:status, 'Published')
  end

  def md_to_html( field )
    return '' if instance_eval(field.to_s).blank?
    Kramdown::Document.new( instance_eval(field.to_s), :auto_ids => false).to_html
  end

  def raw_md_to_html( field )
    return '' if field.to_s.blank?
    Kramdown::Document.new( field.to_s, :auto_ids => false).to_html
  end

  def content_to_markdown
    Markdownifier.new.html_to_markdown( self.content )
  end

  def self.remove_stop_words string
    eng_stop_list = Rails.cache.fetch('stop_words') do
      CSV.read( "#{Rails.root.to_s}/lib/assets/eng_stop.csv" )
    end
    string = (string.downcase.split - eng_stop_list.flatten).join " "
  end

  def related
    # Rails.cache.fetch("#{self.id}-related") {
    #   return [] if wordcounts.empty?
    #   (Article.search_tank(self.wordcounts.all(:order => 'count DESC', :limit => 10).map(&:keyword).map(&:name).join(" OR ")) - [self]).first(4)
    # }
  end

  def indexable?
    self.status == "Published"
  end

  def hits
    self.access_count
  end

  def analyse
    qm_after_create
  end

  def self.analyse_all
    Article.all.each { |a| a.analyse }
  end

  def set_access_count_if_nil
    self.access_count = 0 if self.access_count.nil?
  end

  def delete_orphaned_keywords
    orphan_kw_ids = Keyword.all( :select => 'id' ).map{ |kw| kw.id } -
      Wordcount.all( :select => 'keyword_id' ).map{ |wc| wc.keyword_id }
    Keyword.destroy( orphan_kw_ids )
  end

  ### query-magic activerecord callbacks

  # When an article is created
  #   1) Analyse all the text fields and parse them into a frequency map of words. { <word_i> => <freq_i>, [...], <word_n> => <freq_n> }
  #   2) For each word in text, kw = Keyword.find_or_create_by_name(word).(i)
  #   3) Create a new Wordcount row with :keyword_id => kw.id, :article_id => article.id and count as the frequency of the keyword in the article.
  def qm_after_create
    begin
      if self.status == "Published"
        @analyzer ||= RailsNlp::TextAnalyser.new
        text = @analyzer.collect_text(
            :model => self,
            :fields => ['title','content_main','content_main_extra','content_need_to_know','preview','tags','category_name']
          )
        text = @analyzer.clean( text )
        wordcounts = @analyzer.freq_map( text )
        wordcounts.each do |word, frequency|
          kw = Keyword.find_or_create_by_name( word )
          Wordcount.create!(:keyword_id => kw.id, :article_id => self.id, :count => frequency)
        end
      end
    rescue => e
      logger.error "Could not update keywords and wordcounts after create for article: #{self.try(:id)}"
      logger.error "Message: #{e.message} Backtrace: #{e.backtrace}"
    end
  end
  handle_asynchronously :qm_after_create

  def qm_after_update
    begin
      wordcounts.destroy_all
      qm_after_create
      delete_orphaned_keywords
    rescue => e
      logger.error "Could not update keywords and wordcounts after update for article: #{self.id unless self.id.blank?}"
      logger.error "Message: #{e.message} Backtrace: #{e.backtrace}"
    end
  end
  handle_asynchronously :qm_after_update

  def qm_after_destroy
    begin
      wordcounts.destroy_all
      delete_orphaned_keywords
    rescue => e
      logger.error "Could not update keywords and wordcounts after destroy for article: #{self.id unless self.id.blank?}"
      logger.error "Message: #{e.message} Backtrace: #{e.backtrace}"
    end
  end
  handle_asynchronously :qm_after_destroy
end
