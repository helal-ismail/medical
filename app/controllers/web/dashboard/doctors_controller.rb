class Web::Dashboard::DoctorsController < Web::DashboardController

  def index
    url = request.path_info
    @doctors = []
    @clinics = []
    if url.include?('hospitals')
      hospital = Hospital.find(params[:id])
      @clinics = hospital.clinics
      @clinics.each do |clinic|
        @doctors = @doctors + clinic.doctors
      end
    elsif url.include?('clinics')
      clinic = Clinic.find(params[:id])
      @clinics << clinic
      @doctors = clinic.doctors
    else
      @doctors = Doctor.all
      #@clinics = Clinic.private_clinics
    end
  end

end
