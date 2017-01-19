class Web::Dashboard::AppointmentsController < Web::DashboardController

  def index
    @appointments = []
    @doctors = []

    url = request.path_info
    if url.include?('clinics')
      clinic = Clinic.find(params[:id])
      params[:date] = Date.today.strftime unless params[:date].present?
      @appointments = clinic.appointments_by_date(params[:date])
      @doctors = clinic.doctors
    end

  end
end
