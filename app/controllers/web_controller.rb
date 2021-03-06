class WebController < ApplicationController

  rescue_from Exception, :with => :handle_exception
  #before_filter :handleSessionSecurity


 $url_admin_dashboard = "/dashboard"

 $url_hospitals = "/hospitals"
 $url_clinics = "/clinics"
 $url_doctors = "/doctors"
 $url_appointments = "/appointments"
 $url_announcements = "/announcements"
 $url_users = "/users"
 $url_insurance = "/insurance_cos"
  $url_patients = "/patients"


  private
  def handleDashboardURL
    case session[:user]["type"]
    when "SuperAdmin"
      $url_admin_dashboard = "/dashboard"
    when "HospitalAdmin"
      user = User.find(session[:id])
      $url_admin_dashboard = "/hospitals/"+user.hospital_id.to_s
    end
  end
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
    return false if !session[:id].present?
    user = User.find(session[:id])
    if user.present? and user.access_token == session[:access_token]
    return true
    else
    return false
    end
  end

end
