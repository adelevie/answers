class QuickAnswersController < ApplicationController
  add_breadcrumb('Home', :root_url)
  
  def show
    article = QuickAnswer.friendly.find(params[:id])
    unless article
      add_breadcrumb "(404) Page not found"
      return render(:template => 'articles/missing') 
    end

    unless article.published?
      add_breadcrumb "(404) Page not found"
      return render(template: 'articles/missing') 
    end

    article.delay.record_hit

    unless article.render_markdown
      content_html = article.content
      render :show_html and return
    end

    add_breadcrumb(article.category.name, article.category) if article.category.present?
    add_breadcrumb(article.title)

    content_main =  article.md_to_html( :content_main )
    content_main_extra = article.md_to_html( :content_main_extra )
    content_need_to_know =  article.md_to_html( :content_need_to_know )
    content_main_es =  article.md_to_html( :content_main_es )
    content_main_cn =  article.md_to_html( :content_main_cn )

    respond_to do |format|
      format.html do
        render locals: {
          article: article,
          content_html: content_html,
          content_main: content_main,
          content_main_extra: content_main_extra,
          content_need_to_know: content_need_to_know,
          content_main_es: content_main_es,
          content_main_cn: content_main_cn
        }
      end
      format.json { render json: article }
    end
  end
end
