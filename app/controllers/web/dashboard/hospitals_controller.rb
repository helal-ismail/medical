class Web::Dashboard::HospitalsController < Web::DashboardController

  def index
    @hospitals = Hospital.all
  end

  def new

  end
end
