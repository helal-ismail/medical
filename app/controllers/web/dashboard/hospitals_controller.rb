class Web::Dashboard::HospitalsController < Web::DashboardController

  def index
    @hospitals = Hospital.all
  end

  def new
    url = request.path_info
    @redirect_url = url.gsub("/new","")
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
