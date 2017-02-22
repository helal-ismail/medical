class Web::Dashboard::DoctorsController < Web::DashboardController

  def index
    url = request.path_info
    @doctors = []
    @clinics = []
    @entity_id = ""
    @entity_type = ""

    if url.include?('hospitals')
      hospital = Hospital.find(params[:id])
      @entity_type = "hospital"
      @entity_id = hospital.id
      @clinics = hospital.clinics
      @clinics.each do |clinic|
        @doctors = @doctors + clinic.doctors
      end
    elsif url.include?('clinics')
      clinic = Clinic.find(params[:id])
      @entity_type = "clinic"
      @entity_id = clinic.id
      @clinics << clinic
      @doctors = clinic.doctors
    else
      @doctors = Doctor.all
      #@clinics = Clinic.private_clinics
    end
  end

  def show
  end

end
