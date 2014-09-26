module Answers
  class Api::V1::TaggingsController < Answers::Api::V1::ApiController
    respond_to :json

    def index
      taggings = ActsAsTaggableOn::Tagging.all
      render locals: {taggings: taggings}
    end

    def show
      puts "SHOW!!!"
      tagging = ActsAsTaggableOn::Tagging.find(params[:id])
      render locals: {tagging: tagging}
    end
  
    def create
      tagging = ActsAsTaggableOn::Tagging.new(tagging_params)
      tagging.save
      render 'tagging/show', locals: {tag: tagging}
    end

    def update
      tagging = ActsAsTaggableOn::Tagging.find(params[:id])
      tagging.update(tagging_params)
      render 'tagging/show', locals: {tagging: tagging}
    end

    def destroy
      tagging = ActsAsTaggableOn::Tagging.find(params[:id])
      tagging.destroy
      render 'tagging/show', locals: {tagging: tagging}
    end

    private
      def tagging_params
        params.require(:tagging).permit(
          :tag_id,
          :taggable_id,
          :taggable_type,
          :tagger_id,
          :tagger_type,
          :context
        )
      end
  end
end
