class GuidesController < ApplicationController
	add_breadcrumb("Home", :root_url)
  
  def show
    @article = Guide.friendly.find(params[:id])
    return render(template: 'articles/missing') unless @article && @article.published?

    @article.delay.record_hit
    
    add_breadcrumb(@article.category.name, @article.category) if @article.category.present?
    add_breadcrumb(@article.title)

    if !@article.render_markdown
      @content_html = @article.content
      hr = /<hr( \/)?>/
      if @content_html.match hr
        @content_html.gsub!(hr,"</div>")
        @content_html = "<div class='quick_top'>" + @content_html
      end
      render :show_html and return
    end

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end
end
