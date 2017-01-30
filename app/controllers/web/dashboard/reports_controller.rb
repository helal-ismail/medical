class Web::Dashboard::ReportsController < Web::DashboardController

  def generate_report
    url = request.path_info
    if url.include?('hospitals')
      set_hospital_params
    else
      set_clinic_params
    end
  end

  private
  def set_clinic_params
    @clinic = Clinic.find(params[:id])
    @items = @clinic.doctors
    @report_url = "/api/doctors/reports.csv"
    @label = "Select Doctors :"
  end

  def set_hospital_params
    @hospital = Hospital.find(params[:id])
    @items = @hospital.clinics
    @report_url = "/api/clinics/reports.csv"
    @label = "Select Clinics :"
  end
end
