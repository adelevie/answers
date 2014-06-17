module ArticlesHelper
  def category_listing_title_tag(article)
    if article.category
      return content_tag(:h1, link_to(article.category.name, article.category))
      return content_tag(:h1, link_to(article.category.name, article.category))
    else
      return content_tag(:h1, "Miscellaneous")
    end
  end
  
  def language_preview(article, language)
    lang = languages[language]
    if article.attributes[lang[:attr]].present?
      return content_tag(:div, class: lang[:div_class]) do
        content_tag(:img, source: lang[:img])
        content_tag(:h3, link_to(article.attributes[lang[:attr]], article))
        content_tag(:p, article.attributes[lang[:preview_attr]])
      end
    end
  end
    
  def article_list_tag(article_id, description)
    content_tag(:li, link_to(description, article_path(article_id)))
  end

  def missing_article_list_tag(article_id, description)
    content_tag(:li, description, :class => "missing-article")
  end

  def group_articles_by_category(articles)

    articles.map {|a| a.category.name}.uniq.map do |c|
      {
        category: c,
        articles: articles.select {|a| a.category.name == c}

      }
    end

  end

  
  private
  
  def languages
    {
      es: {
        img: "/assets/es.gif",
        title: "This content is also in Spanish",
        attr: :title_es,
        preview_attr: :preview_es,
        div_class: "preview-es"
      },
      cn: {
        img: "/assets/cn.gif",
        title: "This content is also in Chinese",
        attr: :title_cn,
        preview_attr: :preview_cn,
        div_class: "preview-cn"
      }
    }
  end
end
