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
    case session[:user]["type"]
    when "SuperAdmin"
      @hospitals = Hospital.all
    when "HospitalAdmin"
      user = User.find(session[:id])
      hospital = Hospital.find(user.hospital_id)
      @hospitals = [hospital]
    end
  end

  def edit
    @admin_id = params[:id]
    case session[:user]["type"]
    when "SuperAdmin"
      @hospitals = Hospital.all
    when "HospitalAdmin"
      user = User.find(session[:id])
      hospital = Hospital.find(user.hospital_id)
      @hospitals = [hospital]
    end
    render :file => "web/dashboard/users/new"
  end


end
