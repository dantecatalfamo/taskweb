class ApplicationController < ActionController::Base
  before_action :authorize
  helper_method :current_user, :logged_in?, :admin?

  def current_user
    return unless session[:user_id]

    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    reset_session
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user.admin
  end

  def authorize
    redirect_to login_path, alert: 'You must be logged in to access this page' if current_user.nil?
  end

  def authorize_admin
    redirect_to home_path unless admin?
  end
end
