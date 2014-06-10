class Department < ActiveRecord::Base
  has_many :users

  def self.default_scope
  	order('name ASC')
  end
end