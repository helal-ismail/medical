class Web::Dashboard::AppointmentsController < Web::DashboardController

  def index
    @appointments = []
    @doctors = []
    @clinic_id = ""

    url = request.path_info
    if url.include?('clinics')
      @clinic_id = params[:id]
      clinic = Clinic.find(params[:id])
      params[:date] = Date.today.strftime unless params[:date].present?
      @appointments = clinic.appointments_by_date(params[:date])
      @doctors = clinic.doctors
    end

  end
end
