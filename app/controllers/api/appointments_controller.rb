class Api::AppointmentsController < ApiController

  api :POST, '/appointment', "Create a New Appointment"
  param :appointment, Hash, :desc => 'Appointment Hash', :required => true do
    param :patient_id, String, :desc => "Patient ID", :required => true
    param :doctor_id, String, :desc => "Doctor ID", :required => true
    param :clinic_id, String, :desc => "Clinic ID", :required => true
    param :discount, String, :desc => "discount percentage [0 - 100]", :required => false
    param :appointment_date, String, :desc => "Date", :required => true
    param :appointment_time, String, :desc => "Time", :required => true    
 end
  def add_appointment
    appointment_params = params[:appointment]
    appointment = Appointment.create_from_params(appointment_params)
    render :json=> {:data => appointment, :success => true}
  end

  
  api :POST, '/appointment/note', "Leave Note in an Appointment"
  param :appointment_id, String, :desc => "Appointment ID", :required => true
  param :notes, String, :desc => "Text Note", :required => true
  
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
  param :appointment_id, String, :desc => "Appointment ID", :required => true
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
  param :appointment_id, String, :desc => "Appointment ID", :required => true  
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
