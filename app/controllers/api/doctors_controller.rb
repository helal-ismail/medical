class Api::DoctorsController < ApiController

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
end
