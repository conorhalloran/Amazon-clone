class Api::BaseController < ApplicationController

    protect_from_forgery with: :null_session
    # before_action :authenticate_api_user

    private

    def authenticate_api_user
        @api_user = User.find_by_api_key request.headers['HTTP_API_KEY']
        head :unauthorized unless @api_user
    end

end
