class Web::Dashboard::PatientsController < Web::DashboardController

  def index
    @patients = Patient.all
  end

  def new

  end


end
