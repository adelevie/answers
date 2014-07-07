class DevelopersController < ApplicationController
  add_breadcrumb('Home', :root_url)
  
  def show
    add_breadcrumb('Developers')
    base_url = ''
    if ENV['RAILS_ENV'] == 'development'
      base_url = "http://#{request.domain}:#{request.port}"
    else
      base_url = "https://#{request.domain}"
    end
    
    render locals: { base_url: base_url }
  end
end