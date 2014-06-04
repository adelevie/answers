class Category < ActiveRecord::Base
  extend FriendlyId
  attr_accessible :access_count, :name, :description
  has_many :articles

  before_validation :set_access_count_if_nil

  friendly_id :name, use: [:slugged, :history]

  default_scope order('name ASC')
  scope :by_access_count, order('access_count DESC')
  
  def self.with_published_articles
    self.joins(:articles).where(articles: {status: "Published"}).distinct
    self
  end

  # might want to deprecate
  def has_a_published_article?
    self.articles.map(&:published?).include?(true)
  end

  def has_a_published_article?
    self.articles.map(&:published?).include?(true)
  end

  private

  def hits
    access_count
  end

  def set_access_count_if_nil
    self.access_count = 0 if access_count.nil?
  end

end
