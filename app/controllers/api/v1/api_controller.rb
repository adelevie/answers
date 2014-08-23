class Api::V1::ApiController < ApplicationController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  prepend_view_path "app/views/api/v1"
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  private
  
    def record_not_found
      render json: {message: '404 Not Found', status: 404}, status: 404
    end
end
