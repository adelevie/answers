AnswersGem::Engine.routes.draw do  
  root to: 'home#index'
  
  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :questions
      resources :answers
    end
  end
end
