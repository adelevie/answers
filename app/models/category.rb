class Category < ActiveRecord::Base
  extend FriendlyId
  has_many :articles

  before_validation :set_access_count_if_nil

  friendly_id :name, use: :slugged

  def self.with_published_articles
    self.joins(:articles).where(articles: {status: "Published"}).distinct
  end

  def self.by_access_count
    order('access_count DESC')
  end

  def self.default_scope
    order('name ASC')
  end

  def record_hit
    update_column(:access_count, access_count.to_i + 1 )
  end

  private

  def hits
    access_count
  end

  def set_access_count_if_nil
    self.access_count = 0 if access_count.nil?
  end

end
