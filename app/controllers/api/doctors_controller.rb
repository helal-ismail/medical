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
    uid = params[:uid]
    doctor = Doctor.find_by_uid(uid)
    if doctor.present?
      render :json => {:data => doctor}
    else
      render :json => {:msg => "Doctor UID not found"}, :status => 400
    end
  end

  def schedule
    uid = params[:uid]
    doctor = Doctor.find_by_uid(uid)
    if doctor.present?
      start_time = "2:00pm"
      count = 0
      duration = 15*60
      slots = []
      9.times do
        time = (Time.parse(start_time) + count * duration).strftime("%r")
        count+=1
        available = true
        available = false if count % 2 == 0
        slot = {:time => time, :availabe => available}
        slots << slot
      end
      render :json => {:data => slots}
    else
      render :json => {:msg => "Doctor UID not found"}, :status => 400
    end
  end

  api :GET, '/doctor', "Get Doctor by ID"
  param :doctor_id, String, :desc => "Doctor ID", :required => true

  def get_doctor

  end

  api :GET, '/doctors', "Get a List of Doctors by a Specific Query"

  def get_doctors

  end

  api :POST, '/doctor/feedback', "Leave Feedback to Doctor"
  param :doctor_id, String, :desc => "Doctor ID", :required => true
  param :feedback, String, :desc => "Text Feedback", :required => true
  param :stars, Integer, :desc => "Stars count [ 1 (Worst) - 5 (Best) ]", :required => true

  def add_feedback

  end

  api :POST, '/doctor/schedule', "Set Doctor's Schedule"
  param :doctor_id, String, :desc => "Doctor ID", :required => true
  param :schedule, Array, :desc => "JSON Array of weekdays / schedule", :required => true

  def set_schedule
    doctor_price = DoctorPrice.find_by_doctor_and_clinic(params[:doctor_id], params[:clinic_id])
    schedule = JSON.parse params[:schedule].downcase
    schedule.each do |schedule_json|
      add_daily_schedule(schedule_json)
    end
    render :json => {:success => true, :message => "Schedule has been updated"}
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
