module ActiveAdmin::ViewsHelper
  def article_content_form(article, form)
    if (article.type == 'WebService' || article.type == 'QuickAnswer')
      render partial: "shared/admin/article_content", locals: { f: form, article: article }
    end
  end
end
