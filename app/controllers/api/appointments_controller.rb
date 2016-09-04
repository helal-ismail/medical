class Api::AppointmentsController < ApiController

  api :POST, '/appointment', "Create a New Appointment"
    
  def add_appointment
    appointment_params = params[:appointment]
    appointment = Appointment.create_from_params(appointment_params)
    render :json=> {:data => appointment, :success => true}
  end

  
  api :POST, '/appointment/note', "Leave Note in an Appointment"  
  def add_note
    appointment = Appointment.find(params[:appointment_id])
    response = {}
    status = 200
    if appointment.present?
      appointment.notes = params[:notes]
      response = {:msg=> "Notes werer added", :success=> true}
    else
      response = {:msg=> "Invalid Appointment ID", :success=> false}
      status = 400
    end
    render :json => response , :status => status
  end

  api :POST, '/appointment/cancel', "Cancel an Appointment"  
  def cancel_appointment
    appointment = Appointment.find(params[:appointment_id])
    response = {}
    status = 200
    if appointment.present?
#      appointment.status = ''
      response = {:msg=> "Appointment was canceled", :success=> true}
    else
      response = {:msg=> "Invalid Appointment ID", :success=> false}
      status = 400
    end
    render :json => response , :status => status
  end
  
  api :POST, '/appointment/edit', "Edit an Appointment"  
  def edit_appointment
    
  end
  
  api :GET, '/appointment', "Get an Appointment by ID"  
  def get_appointment
    appointment = Appointment.find(params[:id])
    response = {}
    status = 200
    if appointment.present?
      appointment.notes = params[:notes]
      response = {:data=> appointment, :success=> true}
    else
      response = {:msg=> "Invalid Appointment ID", :success=> false}
      status = 400
    end
    render :json => response , :status => status
  end
  
  api :GET, '/appointments', "Get a List of Appointments by a Specific Query"  
  def get_appointments
    
  end
end
