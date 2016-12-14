class Api::DoctorsController < ApiController

  def add_schedule
    doctor = Doctor.find_by_uid(params[:doctor_uid])
    clinic = Clinic.findi_by_uid(params[:clinic_uid])
    doctor_price  = DoctorPrince.find_by_doctor_and_clinic
    doctor_price.add_daily_schedule(params) if doctor_price.present?

    render :json => {:msg =>"Schedule updated"}

  end

  def get_appointments
    date = Date.parse(params[:date])
    day_of_week = date.wday
    doctor = Doctor.find_by_uid(params[:doctor_uid])
    clinic = Clinic.findi_by_uid(params[:clinic_uid])
    if doctor.present? && clinic.present?
      doctor_price  = DoctorPrince.find_by_doctor_and_clinic
      if doctor_price.present?
        schedules = doctor_price.daily_schedules.where(:day_of_week => day_of_week )
        render :json => {:data => schedules}
      end
    end
    render :json => {:msg => "Something went wrong"}, :status => 500

  end

  def profile
    doctor = Doctor.find(params[:id])
    if doctor.present?
      render :json => {:data => doctor.as_json(:detailed_info=> true)}
    else
      render :json => {:msg => "Doctor ID not found"}, :status => 400
    end
  end


  api :GET, '/doctor/schedule', "Get Doctor's Schedule"
  param :doctor_id, String, :desc => "Doctor ID", :required => true
  param :clinic_id, String, :desc => "Clinic ID", :required => true

  def get_schedule
    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    render :json => {:success => true, :data => doctor_price.daily_schedule}
  end

  api :POST, '/doctor/search', "Search Doctors"
  def search
    pattern = params[:pattern]
    render :json => {:data=>Doctor.search_by_pattern(pattern)}
  end

end
