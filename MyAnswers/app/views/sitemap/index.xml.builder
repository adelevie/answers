xml.instruct!

xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  @locales.each do |locale|
    ::I18n.locale = locale
      # Add XML entry only if there is a valid page_url found above.
      xml.url do
        xml.loc url_for(page_url)
        xml.lastmod page.updated_at.to_date
      end if page_url.present? and page.show_in_menu?
    end
  end

end
