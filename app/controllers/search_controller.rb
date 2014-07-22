# this will mostly be overwritten by the searchkick pr. just want to ensure tests pass.

class SearchController < ApplicationController
  def index
    query =  params[:q].strip
    return redirect_to root_path if params[:q].blank?

    categories = Category.all

    results = Article.search(query)
    Rails.logger.info "search-request: IP:#{request.env['REMOTE_ADDR']}, params[:query]:#{query}, QUERY:#{query}, FIRST_RESULT:#{results.first.title unless results.empty?}, RESULTS_N:#{results.size}"

    categories = Category.all
    if categories.nil?
      categories = []
    end
    
    
    respond_to do |format|
      format.json { render json: results }
      format.html do 
        render locals: {
          results: results, 
          query: query,
          categories: categories
        } 
      end
    end
  end

end
