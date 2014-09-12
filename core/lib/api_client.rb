require 'weary'
require 'json'

DEVELOPMENT_DOMAIN = "http://localhost:3000"

module APIClient
  class Answer < Weary::Client
    domain DEVELOPMENT_DOMAIN if Rails.env.development?
    domain PRODUCTION_DOMAIN  if Rails.env.production?
    
    get :all, "/answers.json"
    get :find, "/answers/{id}.json"
    
    post :create, "/answers.json" do |resource|
      resource.optional :need_to_know
      resource.required :text, :in_language
    end
  end
end

