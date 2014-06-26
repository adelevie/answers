class QuickAnswersController < ApplicationController
  add_breadcrumb('Home', :root_url)
  
  def show
    article = QuickAnswer.friendly.find(params[:id])
    
    unless article || article.published?
      add_breadcrumb "(404) Page not found"
      respond_to do |format|
        format.html { return render template: 'articles/missing'  }
        format.json { return render json: article }
      end
    end
    
    add_breadcrumb(article.category.name, article.category) if article.category.present?
    add_breadcrumb(article.title)

    article.delay.record_hit

    unless article.render_markdown
      content_html = article.content
      respond_to do |format|
        locals = {
          article: article,
          content_html: content_html
        }
        format.html { return render locals: locals }
        format.json { return render json: locals }
      end
    end

    locals = {
      article: article,
      content_html: content_html,
      content_main: article.md_to_html(:content_main),
      content_main_extra:  article.md_to_html(:content_main_extra),
      content_need_to_know: article.md_to_html(:content_need_to_know),
      content_main_es: article.md_to_html(:content_main_es),
      content_main_cn: article.md_to_html(:content_main_cn)
    }

    respond_to do |format|
      format.html { render locals: locals }
      format.json { render json: locals }
    end
  end
end
