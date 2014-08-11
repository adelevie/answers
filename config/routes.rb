Answers::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :sessions => "sessions" }

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :questions
      resources :answers
    end
  end
  
  match '/about' => "home#about" , :as => :about, :via => :get
  match '/search/' => "search#index" , :as => :search, :via => [:get, :post]
  match 'autocomplete' => "search#autocomplete", :via => :get
  match '/articles/article-type/:content_type' => "articles#article_type", as: :articles_type, :via => :get

  post "search/reindex_articles", to: "search#reindex_articles"
  
  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
  
  root :to => "home#index"
end