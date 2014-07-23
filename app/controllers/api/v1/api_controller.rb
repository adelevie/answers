class Api::V1::ApiController < ApplicationController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  prepend_view_path "app/views/api/v1"
end
