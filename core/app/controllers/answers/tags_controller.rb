module Answers
  class TagsController < Answers::ApplicationController
    # caches_page :index
    # caches_page :show 
    
    add_breadcrumb "Home", :answers_path
    
    def index
      add_breadcrumb "Tags", answers.tags_path
      
      tags = ActsAsTaggableOn::Tag.all
      render locals: {tags: tags}
    end

    def show
      tag = ActsAsTaggableOn::Tag.friendly.find(tag_params[:id])

      add_breadcrumb "Tags", answers.tags_path
      add_breadcrumb tag.name.capitalize, answers.tag_path(tag)
      
      questions = Question.tagged_with(tag.name)
      
      render locals: {
        tag: tag,
        questions: questions
      }
    end

    protected
    def tag_params
      params.permit(:id)
    end
  end
end
