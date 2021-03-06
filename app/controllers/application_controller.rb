class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  def user_signed_in?
      current_user.present?
  end
  helper_method :user_signed_in?

  def current_user
      @current_user ||= User.find_by_id session[:user_id]
  end
  helper_method :current_user

  def liked_by?(current_user)
    likes.find_by_user_id(current_user.id).present?
  end
  helper_method :liked_by?
end
