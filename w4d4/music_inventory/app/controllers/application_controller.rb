class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_current_user!, except: [:create, :new]

  helper_method :logged_in?
  helper_method :current_user

  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def logged_in?
    session[:session_token].nil? ? false : true
  end

  def logout_user!
    session[:session_token] = nil
    redirect_to root_url
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def require_current_user!
    redirect_to new_session_url if current_user.nil?
  end
end
