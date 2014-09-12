module AnswersGem

  class Administrator < ActiveRecord::Base
    devise :database_authenticatable, :lockable, :timeoutable, :recoverable, :trackable
  end

end