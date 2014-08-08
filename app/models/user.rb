class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :registerable,
  
  #acts_as_token_authenticatable
    
  belongs_to :department
  # has_many :articles
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  after_validation :make_roles_exclusive

  def to_s
    email
  end

  private

  def make_roles_exclusive
    if is_admin
      self.is_editor = false
      self.is_writer = false
    elsif is_editor
      self.is_writer = false
    end
  end
end
