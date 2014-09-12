Answers::Core::Engine.routes.draw do

  match '/about' => "home#about" , :as => :about, :via => :get
  match '/search/' => "search#index" , :as => :search, :via => [:get, :post]
  match '/search/tag/' => "search#tag_search" , :as => :tag_search, :via => [:get, :post]
  match 'autocomplete' => "search#autocomplete", :via => :get
  match '/articles/article-type/:content_type' => "articles#article_type", as: :articles_type, :via => :get
  post "search/reindex_articles", to: "search#reindex_articles"
  
  resources :questions, only: [:index, :show], :path => 'answers', :as => 'answers'
  resources :tags, only: [:index, :show]

	root to: 'home#index'

 # get '/sitemap.xml' => 'sitemap#index', :defaults => { :format => 'xml' }
end
