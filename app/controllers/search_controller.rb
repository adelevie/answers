class SearchController < ApplicationController
  def index
    query =  params[:q].strip
    
    conditions = {}
    conditions[:tag_name] = params[:tag].strip if params[:tag].present?

    return redirect_to root_path if params[:q].blank?
    
    results = Question.search(query, where: conditions, index_name: [Question.searchkick_index.name], facets: {tag_name: {where: conditions}})
    
    Rails.logger.info "search-request: IP:#{request.env['REMOTE_ADDR']}, params[:query]:#{query}, QUERY:#{query}, FIRST_RESULT:#{results.first.text unless results.empty?}, RESULTS_N:#{results.size}"

    respond_to do |format|
      format.json { render json: results }
      format.html do 
        render locals: {
          results: results, 
          query: query,
          facets: results.facets,
          filter: conditions[:tag_name]
        } 
      end
    end
  end

end
