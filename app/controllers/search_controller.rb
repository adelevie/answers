class SearchController < ApplicationController
  def index
    query =  params[:q].strip
    if params[:q].blank?
       redirect_to root_path
       return
    end
    results = Question.search(query, index_name: [Question.searchkick_index.name])#, Answer.searchkick_index.name])
    
    Rails.logger.info "search-request: IP:#{request.env['REMOTE_ADDR']}, params[:query]:#{query}, QUERY:#{query}, FIRST_RESULT:#{results.first.text unless results.empty?}, RESULTS_N:#{results.size}"

    respond_to do |format|
      format.json { render json: results }
      format.html do 
        render locals: {
          results: results, 
          query: query
        } 
      end
    end
  end

end
