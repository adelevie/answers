Answers::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :sessions => "sessions" }

  #### API
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :questions
      resources :answers
    end
  end
  
  
  #namespace :api, defaults: {format: 'json'} do
  #  namespace :v1 do
  #    resources :questions
  #    resources :answers
  #  end
  #end
  #### /API


  get "quick_answer/show"
  get "category/index"

  match '/about' => "home#about" , :as => :about, :via => :get
  match '/search/' => "search#index" , :as => :search, :via => [:get, :post]
  match 'autocomplete' => "search#autocomplete", :via => :get
  match '/articles/article-type/:content_type' => "articles#article_type", as: :articles_type, :via => :get

  resources :articles
  resources :categories
  resources :contacts
  resources :guides
  resources :quick_answers
  resources :web_services
  
  resources :questions, only: [:index, :show]
  resources :answers, only: [:index, :show]

  root :to => "home#index"
end
