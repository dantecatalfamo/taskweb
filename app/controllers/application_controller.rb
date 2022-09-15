class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  def authorize
    redirect_to login_path, alert: 'You must be logged in to access this page' if current_user.nil?
  end
end
