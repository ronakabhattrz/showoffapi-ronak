class Api::V1::ApiController < ApplicationController
	before_action :authenticate_client
	before_action :current_user

	def current_user
		if request.headers['Authorization'].present?
			user 
		end
	end

	private
		def authenticate_client
			return if request.headers["Authorization"].present?
			client_id = params[:client_id]
			client_secret = params[:client_secret]
			client = Client.find_by(client_id: client_id, client_secret: client_secret)
			render json: { error: "Invalid Client." }, status: :unauthorized if !client.present?
		end


		def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      @user ||= nil
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
    end

    def http_auth_header
      if request.headers['Authorization'].present?
        return request.headers['Authorization'].split(' ').last
      else
        errors.add(:token, 'Missing token')
      end
      nil
    end

end
