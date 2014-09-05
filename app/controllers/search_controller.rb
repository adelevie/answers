class SearchController < ApplicationController
  def index
    query = params[:q].strip if params[:q].present?
    
    return redirect_to root_path if params[:q].blank?
    
    results = Question.search(query, index_name: [Question.searchkick_index.name, Answer.searchkick_index.name])
    
    Rails.logger.info "search-request: IP:#{request.env['REMOTE_ADDR']}, params[:query]:#{query}, QUERY:#{query}, FIRST_RESULT:#{results.first.text unless results.empty?}, RESULTS_N:#{results.size}"

    respond_to do |format|
      format.json { render json: results }
      format.html do 
        render locals: {
          results: results, 
          query: query,
        } 
      end
    end
  end

  def tag_search

    conditions = {}
    conditions[:tag_name] = params[:tag].strip if params[:tag].present?

    return redirect_to root_path if params[:tag].blank?

    results = Question.search(where: conditions, index_name: [Question.searchkick_index.name, Answer.searchkick_index.name])

    respond_to do |format|
      format.json { render json: results }
      format.html do 
        render locals: {
          results: results, 
          tag: conditions[:tag_name]
        } 
      end
    end
  end

end
