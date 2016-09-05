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
    
  end
  
  api :GET, '/doctor/schedule', "Get Doctor's Schedule"
  param :doctor_id, String, :desc => "Doctor ID", :required => true
  def get_schedule
    
  end
end
