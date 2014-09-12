class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	#protect_from_forgery with: :exception
  #protect_from_forgery with: :null_session
  
  protect_from_forgery with: :null_session

 # helper_method :current_ability
 # helper_method :current_admin_user
 # helper_method :correct_user?
 # helper_method :bodyclass

  ensure_security_headers(
    :hsts => {:max_age => 631138519, :include_subdomains => false},
    :x_frame_options  => {:value => 'SAMEORIGIN'},
    :x_xss_protection => {:value => 1, :mode => 'block'},
    :x_content_type_options => {:value => 'nosniff'},
    :csp => false
  )

  def redirect_to_back(default = root_url)
    if !request.env["HTTP_REFERER"].blank? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  private
  
  def bodyclass
    "body"
  end

end
