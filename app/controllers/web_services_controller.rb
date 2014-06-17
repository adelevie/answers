class WebServicesController < ApplicationController
  add_breadcrumb('Home', :root_url)

  def show
    @article = WebService.friendly.find(params[:id])
    return render(template: 'articles/missing') unless @article && @article.published?

    @article.delay.record_hit

    add_breadcrumb(@article.category.name, @article.category) if @article.category.present?
    add_breadcrumb(@article.title)

    @content_main =  @article.md_to_html( :content_main )
    @content_main_extra = @article.md_to_html( :content_main_extra )
    @content_need_to_know =  @article.md_to_html( :content_need_to_know )

    respond_to do |format|
      format.html
      format.json { render json: @article }
    end
  end
end
