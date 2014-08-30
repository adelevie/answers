module TagsHelper
  def tag_path(tag)
    "/tags/#{tag.id}"
  end
end
