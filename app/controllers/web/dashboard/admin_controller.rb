class Web::Dashboard::AdminController < Web::DashboardController

  def index
    @hospitals = Hospital.all.count
    @clinics = Clinic.private_clinics.count
    @doctors = Doctor.all.count
  end

  def announcements
  end

end
