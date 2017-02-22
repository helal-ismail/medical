class Web::Dashboard::UsersController < Web::DashboardController

  def index
    case session[:user]["type"]
    when "SuperAdmin"
      @admins = User.admins
    when "HospitalAdmin"
      user = User.find(session[:id])
      @admins = User.where(:hospital_id => user.hospital_id)
    end
  end

  def new

  end


end
