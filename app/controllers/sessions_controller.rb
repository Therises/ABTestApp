class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])
    cookies[:unique_token] = user.unique_token
    redirect_to root_url
  end

  def destroy
    cookies.delete(:unique_token)
    redirect_to welcome_url
  end
end
