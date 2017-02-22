class Web::Dashboard::HospitalsController < Web::DashboardController

  def index
    if session[:user]["type"] == "SuperAdmin"

      @hospitals = Hospital.all
    end

    case session[:user]["type"]
    when "SuperAdmin"
      @hospitals = Hospital.all
    when "HospitalAdmin"
      user = User.find(session[:id])
      @hospitals = []
      @hospitals << user.hospital
    else
      @hospitals = []
    end
  end

  def new
    url = request.path_info
    @redirect_url = url.gsub("/new","")
    @hospital_id = 0
  end

  def edit
    @hospital_id = params[:id]
    url = request.path_info
    @redirect_url = url.gsub("/edit","")
    render :file => "web/dashboard/hospitals/new"
  end

  def dashboard
    hospital = Hospital.find(params[:id])
    @clinics = hospital.clinics.count

    @doctors = 0
    hospital.clinics.each do |clinic|
      @doctors = @doctors + clinic.doctors.count
    end

    @clinics_url = "/hospitals/#{params[:id]}/clinics"
    @doctors_url = "/hospitals/#{params[:id]}/doctors"
    @reports_url = "/hospitals/#{params[:id]}/reports"


  end
end
