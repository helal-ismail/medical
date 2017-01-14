class Web::Dashboard::ClinicsController < Web::DashboardController

  def index
    @clinics = Clinic.private_clinics
  end

  def new

  end
end
