class HomeController < ApplicationController

  caches_page :index
  add_breadcrumb "Home", :root_url

  def index
    @popular_categories = Category.with_published_articles.by_access_count.limit(4)
  end

 def about
 	add_breadcrumb "About"
 end

end
