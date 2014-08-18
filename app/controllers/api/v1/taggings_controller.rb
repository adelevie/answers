class Api::V1::TaggingsController < Api::V1::ApiController
  respond_to :json

  def index
    taggings = ActsAsTaggableOn::Tagging.all
    render locals: {taggings: taggings}
  end

  def show
    tagging = ActsAsTaggableOn::Tagging(params[:id])
    render locals: {tagging: tagging}
  end
  
  def create
    tagging = ActsAsTaggableOn::Tagging.new(tagging_params)
    tagging.save
    render 'tagsging/show', locals: {tag: tagging}
  end

  def update
    tag = ActsAsTaggableOn::Tagging.find(params[:id])
    tag.update(tag_params)
    render 'tagsging/show', locals: {tagging: tagging}
  end

  def destroy
    tagging = ActsAsTaggableOn::Tagging.find(params[:id])
    tagging.destroy
    render 'tagsging/show', locals: {tagging: tagging}
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
