class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :authenticate
  # return auth token once user is authenticated
  def authenticate

   auth_params = JSON.parse(request.body.read).symbolize_keys
   auth_token =
      AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
	   user = User.find_by(email: auth_params[:email]) 
   json_response({success: true, auth_token: auth_token, user: user})
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
