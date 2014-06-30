# this will mostly be overwritten by the searchkick pr. just want to ensure tests pass.

class SearchController < ApplicationController
  def index
    query =  params[:q].strip
    return redirect_to root_path if params[:q].blank?
    query = Article.remove_stop_words query

    ### this is all going away soon
    
    # Searchify can't handle requests longer than this
    # (because of query expansion + Tanker inefficencies.
    # >10 can result in >8000 byte request strings)
    results = []
    if query.split.size > 10 || query.blank?
      results = []
    end

    results = Article.search_tank(query) #rescue []
    Rails.logger.info "search-request: IP:#{request.env['REMOTE_ADDR']}, params[:query]:#{query}, QUERY:#{query}, FIRST_RESULT:#{results.first.title unless results.empty?}, RESULTS_N:#{results.size}"

    categories = Category.all
    if categories.nil?
      categories = []
    end
    
    #binding.pry
    
    respond_to do |format|
      format.json { render results }
      format.html do 
        render locals: {
          results: results,
          query: query,
          categories: categories
        }
      end
    end
  end

  def reindex_articles
    Article.tanker_reindex
    respond_to do |format|
      format.json { render json: true }
    end
  end
end
