class Web::Dashboard::ReportsController < Web::DashboardController

  def clinic
    @clinic = Clinic.find(params[:id])
    @doctors = @clinic.doctors
    @report_url = ""
  end
end
