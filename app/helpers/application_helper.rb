module ApplicationHelper
  def current_user
    @current_user ||= User.find(session[:uid]) if session[:uid]
  end
end
