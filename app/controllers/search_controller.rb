class SearchController < ApplicationController
  def index
    query =  params[:q].strip
    return redirect_to root_path if params[:q].blank?
    
    results = Question.search(query, page: params[:page], per_page: 10, index_name: [Question.searchkick_index.name, Answer.searchkick_index.name])
    
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
