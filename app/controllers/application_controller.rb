class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @_current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to root_path
    end
  end

  def logged_in?
    !!current_user
  end

  helper_method :current_user, :require_login, :logged_in?
end
