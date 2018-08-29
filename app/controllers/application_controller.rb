class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def current_user
    @current_user ||= User.find_by_unique_token!(cookies[:unique_token]) if cookies[:unique_token]
  end
  
  helper_method :current_user
end
