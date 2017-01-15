class WebController < ApplicationController

  rescue_from Exception, :with => :handle_exception
 # before_filter :handleSessionSecurity

 $url_admin_dashboard = "/dashboard"
 $url_hospitals = "/hospitals"
 $url_clinics = "/clinics"
 $url_doctors = "/doctors"
 $url_appointments = "/appointments"

  private
  def handle_exception(exception)
    flash[:notice] = exception.message
    redirect_to '/error'
  end

  def handleSessionSecurity
    if !isLoggedIn
      redirect_to '/login'
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
