class Api::V1::TagsController < Api::V1::ApiController
  respond_to :json

  def index
    tags = ActsAsTaggableOn::Tag.all
    render locals: {tags: tags}
  end

  def show
    tag = ActsAsTaggableOn::Tag(params[:id])
    render locals: {tag: tag}
  end
  
  def create
    tag = ActsAsTaggableOn::Tag.new(tag_params)
    tag.save
    render 'tags/show', locals: {tag: tag}
  end

  def update
    tag = ActsAsTaggableOn::Tag.find(params[:id])
    tag.update(tag_params)
    render 'tags/show', locals: {tag: tag}
  end

  def destroy
    tag = ActsAsTaggableOn::Tag.find(params[:id])
    tag.destroy
    render 'tags/show', locals: {tag: tag}
  end

  private
    def tag_params
      params.require(:tag).permit(:name, :taggings_count)
    end
end
