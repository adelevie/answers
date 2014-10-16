module Answers
	class Api::V1::ApiUser < User
  	acts_as_token_authenticatable
	end
end
