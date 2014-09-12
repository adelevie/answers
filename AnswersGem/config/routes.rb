AnswersGem::Engine.routes.draw do  
  root to: 'home#index'
  
  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
end
