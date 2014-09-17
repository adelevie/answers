module Answers
  class ApplicationController < ActionController::Base

    protect_from_forgery with: :null_session

    helper_method :current_ability
    helper_method :current_admin_user
    helper_method :correct_user?

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

    def after_sign_in_path_for(resource_or_scope)
      path = stored_location_for(resource_or_scope) || signed_in_root_path(resource_or_scope)
      "/#{path}" if path[0] != "/" # hackity hack
    end


    private
  
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
end