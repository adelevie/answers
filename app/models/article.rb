# encoding: utf-8
include ActionView::Helpers::SanitizeHelper
require 'facets/enumerable'

class Article < ActiveRecord::Base
  searchkick
  
  include Markdownifier

  require_dependency 'keyword'

  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :contact
  belongs_to :category
  belongs_to :user
  has_many :wordcounts
  has_many :keywords, :through => :wordcounts

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

  # A note on the content fields:
  # *  Originally the content for the articles was stored as HTML in Article#content.
  # *  We then moved to Markdown for content storage, resulting in Article#content_md.
  # *  Most recently, the QuickAnswers were split into three distinct sections: content_main, content_main_extra and content_need_to_know. All these use Markdown.

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

  def self.search_titles( query )
    return Article.all if query.blank?
    self.search(where: {title: query})
  end

  def self.find_by_type( content_type )
    return Article.where(:type => content_type).order('category_id').order('access_count DESC')
  end

  def self.by_access_count
    order('access_count DESC')
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
    # TODO: implement with searchkick
  end

  def indexable?
    self.status == "Published"
  end

  def hits
    self.access_count
  end

  def record_hit
    update_column(:access_count, access_count.to_i + 1 )
    category.record_hit if category
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

end
