class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	protect_from_forgery with: :exception

  helper_method :current_ability
  helper_method :current_admin_user
  helper_method :correct_user?
  helper_method :bodyclass

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

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  def correct_user?
    if params[:id]
      @user = User.find(params[:id])
      unless current_user == @user
        flash[:error] = 'Access denied.'
        redirect_to_back admin_root_path
      end
    end
  end

  def current_admin_user
    current_user if current_user && current_user.is_admin?
  end

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to_back admin_root_path
  end
end
