class Contact < ActiveRecord::Base

  has_many :articles

  def self.default_scope
  	order('name ASC')
  end
end
