class Api::AppointmentsController < ApiController

  api :POST, '/appointment', "Create a New Appointment"
  def add_appointment
    
  end

  api :POST, '/appointment/note', "Leave Note in an Appointment"  
  def add_note
    
  end

  api :POST, '/appointment/cancel', "Cancel an Appointment"  
  def cancel_appointment
    
  end
  
  api :POST, '/appointment/edit', "Edit an Appointment"  
  def edit_appointment
    
  end
  
  api :GET, '/appointment', "Get an Appointment by ID"  
  def get_appointment
    
  end
  
  api :GET, '/appointments', "Get a List of Appointments by a Specific Query"  
  def get_appointments
    
  end
end
