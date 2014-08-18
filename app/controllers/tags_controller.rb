class TagsController < ApplicationController
  caches_page :index
  caches_page :show  
  
  def index
    tags = ActsAsTaggableOn::Tag.all
    render locals: {tags: tags}
  end

  def show
    id        = params[:id].to_i
    tag       = ActsAsTaggableOn::Tag.find(id)
    
    taggings  = tag.taggings.select do |tagging| 
      tagging.taggable_type == "Question"
    end
    
    questions = Question.find(
                  taggings.map(&:taggable_id)
                )
    
    render locals: {
      tag: tag,
      questions: questions
    }
  end
end
