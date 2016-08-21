class Api::DoctorsController < ApiController

  api :GET, '/doctor', "Get Doctor by ID"
  def get_doctor
    
  end
  
  api :GET, '/doctors', "Get a List of Doctors by a Specific Query"
  def get_doctors
    
  end
  
  api :POST, '/doctor/feedback', "Leave Feedback to Doctor"
  def add_feedback
    
  end
  
  api :POST, '/doctor/schedule', "Set Doctor's Schedule"
  def set_schedule
    
  end
  
  api :GET, '/doctor/schedule', "Get Doctor's Schedule"
  def get_schedule
    
  end
end
