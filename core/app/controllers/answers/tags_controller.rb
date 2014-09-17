module Answers
  class TagsController < Answers::ApplicationController
    caches_page :index
    caches_page :show 
    
    add_breadcrumb "Home", :answers_path
    
    def index
      add_breadcrumb "Tags", answers.tags_path
      
      tags = ActsAsTaggableOn::Tag.all
      render locals: {tags: tags}
    end

    def show
      id  = params[:id].to_i
      tag = ActsAsTaggableOn::Tag.find(id)
      
      add_breadcrumb "Tags", answers.tags_path
      add_breadcrumb tag.name.capitalize, answers.tag_path(tag)
      
      taggings = tag.taggings.select do |tagging| 
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
end
