module ApplicationHelper

  def format_article_type(article_type)
    article_type.underscore.humanize.titleize
  end
  
  def phone_number_from_article(article)
    if article.contact.number.present? && article.contact.number.length > 0
      return raw "Phone: #{article.contact.number}"
    end
  end

	def official_site_title
		Rails.application.secrets.official_site_title
	end

	def official_style_guide
		Rails.application.secrets.official_style_guide
	end

	def official_city_name
		Rails.application.secrets.official_city_name
	end

	def official_contact_email
		Rails.application.secrets.official_contact_mail
	end

	def official_government_long_url(params = '')
		Rails.application.secrets.official_government_url
	end
	
	def background_image
	  Rails.application.secrets.background_image
  end

	def official_government_short_url(params = '')
		File.basename(official_government_long_url) + params
	end

	def link_to_official_government_website(params = '', name = nil)
		name = name.nil? ? official_government_short_url : name
		link_to(name, "#{official_government_long_url}/#{params}")
	end
end
