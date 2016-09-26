class SessionController < ApplicationController
  before_filter :handleSessionSecurity
  
  
  def login
    
  end
  
  
  private
  
  def handleSessionSecurity
    if !isLoggedIn
      redirect_to ''
    end
  end
  
  def isLoggedIn
    user = User.find_by_uid(session[:uid])
    if user.present? and user.access_token == session[:access_token]
      return true
    else
      return false
    end
  end
  
end
