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

    url = request.path_info
    @hospital_id = 0
    if url.include?('hospitals')
      @hospital_id = params[:id]
    end
    @redirect_url = url.gsub("/new","")
    @clinic_id = 0
    #clinic = Clinic.create(hospital_id: hospital_id, name: params[:clinic_name], phone: params[:clinic_phone], specialization_id: params[:clinic_specialization_id], address: params[:clinic_address])
  end

  def edit
    @clinic_id = params[:clinic_id]
    clinic = Clinic.find(@clinic_id)
    @hospital_id = clinic.hospital_id
    url = request.path_info
    @redirect_url = url.gsub("/edit","")
    render :file => "web/dashboard/clinics/new"
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
