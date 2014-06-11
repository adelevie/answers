Oaklandanswers::Application.routes.draw do
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :sessions => "sessions" }

  get "quick_answer/show"
  get "category/index"

  match '/about' => "home#about" , :as => :about
  match '/search/' => "search#index" , :as => :search, :via => [:get, :post]
  match 'autocomplete' => "search#autocomplete"
  match '/articles/article-type/:content_type' => "articles#article_type", as: :articles_type

  post "search/reindex_articles", to: "search#reindex_articles"

  resources :articles
  resources :categories
  resources :contacts
  resources :guides
  resources :quick_answers
  resources :web_services

  root :to => "home#index"
end
