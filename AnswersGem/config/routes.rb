AnswersGem::Engine.routes.draw do  
  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
end
