class Web::Dashboard::AppointmentsController < Web::DashboardController

  def index
    @appointments = []
    url = request.path_info
    if url.include?('clinics')
      clinic = Clinic.find(params[:id])
      @appointments = clinic.appointments_by_date(Date.today.strftime)
    end
  end
end
