class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  prepend_view_path 'app/theme/generic/views'
end
