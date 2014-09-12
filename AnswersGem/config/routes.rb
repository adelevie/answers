AnswersGem::Engine.routes.draw do
  get "/", controller: "foos", action: :index
  
  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
end
