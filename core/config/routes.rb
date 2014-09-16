Answers::Core::Engine.routes.draw do
  
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :questions
      resources :answers
      resources :tags
      resources :taggings
    end
  end

  match '/about' => "home#about" , :as => :about, :via => :get
  match '/search/' => "search#index" , :as => :search, :via => [:get, :post]
  match 'autocomplete' => "search#autocomplete", :via => :get

  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
  resources :tags, only: [:index, :show]
  # root :to => "home#index"
  match '/' => 'home#index', :via => :get, as: 'home'
  devise_for :users, class_name: "Answers::User", module: :devise
end
