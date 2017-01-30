class Web::Dashboard::ClinicsController < Web::DashboardController

  def index
    url = request.path_info
    @clinics = []
    if url.include?('hospitals')
      hospital = Hospital.find(params[:id])
      @clinics = hospital.clinics
    else
      @clinics = Clinic.private_clinics
    end
  end

  def new

  end

  def dashboard
    clinic = Clinic.find(params[:id])
    @doctors = clinic.doctors.count
    @appointments = clinic.appointments.count
    @doctors_url = "/clinics/#{params[:id]}/doctors"
    @appointments_url = "/clinics/#{params[:id]}/appointments"
    @reports_url = "/clinics/#{params[:id]}/reports"


  end

end
